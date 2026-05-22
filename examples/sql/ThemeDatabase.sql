-- ============================================
-- سناریو پایگاه داده برای معماری هیبریدی
-- ============================================

-- ۱. جدول Theme Versions - ذخیره نسخه‌های مختلف تم
CREATE TABLE ThemeVersions (
    Id INT PRIMARY KEY IDENTITY(1,1),
    VersionName NVARCHAR(100) NOT NULL,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NULL,
    ThemeData NVARCHAR(MAX) NOT NULL, -- JSON کامل تم
    ChangeDescription NVARCHAR(500),
    CreatedBy NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    CONSTRAINT FK_ValidDates CHECK (ValidTo IS NULL OR ValidTo > ValidFrom),
    CONSTRAINT UQ_VersionName_ValidFrom UNIQUE(VersionName, ValidFrom)
);

-- ۲. جدول User Theme Overrides - Override‌های مخصوص کاربر
CREATE TABLE UserThemeOverrides (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    OverrideData NVARCHAR(MAX) NOT NULL, -- JSON شامل فقط تغییرات
    LastModified DATETIME DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(100),
    CONSTRAINT FK_UserId FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT UQ_UserTheme UNIQUE(UserId)
);

-- ۳. جدول Audit Trail - ثبت تغییرات
CREATE TABLE ThemeAuditLog (
    Id BIGINT PRIMARY KEY IDENTITY(1,1),
    ThemeVersionId INT NOT NULL,
    ChangedBy NVARCHAR(100) NOT NULL,
    ChangeType NVARCHAR(50), -- 'CREATE', 'UPDATE', 'ROLLBACK', 'ACTIVATE', 'DEACTIVATE'
    OldValues NVARCHAR(MAX),
    NewValues NVARCHAR(MAX),
    ChangedAt DATETIME DEFAULT GETDATE(),
    IpAddress NVARCHAR(45),
    UserAgent NVARCHAR(500),
    CONSTRAINT FK_ThemeVersion FOREIGN KEY (ThemeVersionId) REFERENCES ThemeVersions(Id)
);

-- ۴. جدول Tenant Themes - برای سیستم‌های Multi-tenant
CREATE TABLE TenantThemes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    TenantId INT NOT NULL,
    ThemeVersionId INT NOT NULL,
    IsDefault BIT DEFAULT 0,
    AppliedFrom DATETIME DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100),
    CONSTRAINT FK_TenantTheme FOREIGN KEY (ThemeVersionId) REFERENCES ThemeVersions(Id),
    CONSTRAINT UQ_TenantDefault UNIQUE(TenantId) WHERE IsDefault = 1
);

-- ۵. جدول Template Bindings - ربط بین MRT Templates و Themes
CREATE TABLE ReportTemplateBindings (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ReportId NVARCHAR(256) NOT NULL,
    TemplateVersion NVARCHAR(100) NOT NULL,
    RequiredThemeVersion NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_ReportTemplate UNIQUE(ReportId, TemplateVersion)
);

-- ============================================
-- Indexes برای Performance
-- ============================================

CREATE CLUSTERED INDEX IX_ThemeVersions_ValidFrom 
    ON ThemeVersions(ValidFrom DESC);

CREATE INDEX IX_ThemeVersions_Active 
    ON ThemeVersions(IsActive) 
    WHERE IsActive = 1;

CREATE INDEX IX_UserOverrides_UserId 
    ON UserThemeOverrides(UserId);

CREATE INDEX IX_AuditLog_ThemeVersionId 
    ON ThemeAuditLog(ThemeVersionId);

CREATE INDEX IX_AuditLog_ChangedAt 
    ON ThemeAuditLog(ChangedAt DESC);

CREATE INDEX IX_TenantThemes_TenantId 
    ON TenantThemes(TenantId);

-- ============================================
-- Stored Procedures
-- ============================================

-- ۱. دریافت تم موثر برای کاربر
CREATE PROCEDURE sp_GetEffectiveTheme
    @UserId INT = NULL,
    @HistoricalDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EffectiveDate DATETIME = ISNULL(@HistoricalDate, GETDATE());

    -- اگر کاربر مشخص شد، ابتدا Override‌های کاربر را بررسی کن
    IF @UserId IS NOT NULL
    BEGIN
        SELECT TOP 1 
            'User' AS ThemeSource,
            uto.OverrideData AS ThemeData,
            tv.VersionName,
            tv.ValidFrom
        FROM UserThemeOverrides uto
        LEFT JOIN ThemeVersions tv ON tv.Id = 
            (SELECT TOP 1 Id FROM ThemeVersions 
             WHERE ValidFrom <= @EffectiveDate 
             AND IsActive = 1
             ORDER BY ValidFrom DESC)
        WHERE uto.UserId = @UserId;
    END
    ELSE
    BEGIN
        -- Override نبود، تم پایه را برگردان
        SELECT TOP 1 
            'Base' AS ThemeSource,
            tv.ThemeData,
            tv.VersionName,
            tv.ValidFrom
        FROM ThemeVersions tv
        WHERE ValidFrom <= @EffectiveDate 
        AND IsActive = 1
        ORDER BY ValidFrom DESC;
    END
END;

-- ۲. ایجاد نسخه جدید Theme
CREATE PROCEDURE sp_CreateThemeVersion
    @VersionName NVARCHAR(100),
    @ThemeData NVARCHAR(MAX),
    @ChangeDescription NVARCHAR(500) = NULL,
    @CreatedBy NVARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        INSERT INTO ThemeVersions (VersionName, ValidFrom, ThemeData, ChangeDescription, CreatedBy)
        VALUES (@VersionName, GETDATE(), @ThemeData, @ChangeDescription, @CreatedBy);
        
        -- ثبت در Audit Log
        INSERT INTO ThemeAuditLog (ThemeVersionId, ChangedBy, ChangeType, NewValues, ChangedAt)
        SELECT SCOPE_IDENTITY(), @CreatedBy, 'CREATE', @ThemeData, GETDATE();
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

-- ۳. بازتولید گزارش با تم تاریخی
CREATE PROCEDURE sp_GetHistoricalReportTheme
    @ReportId NVARCHAR(256),
    @ReportGenerationDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP 1
        tv.Id,
        tv.VersionName,
        tv.ThemeData,
        tv.ValidFrom,
        rtb.TemplateVersion
    FROM ThemeVersions tv
    LEFT JOIN ReportTemplateBindings rtb ON rtb.ReportId = @ReportId
    WHERE tv.ValidFrom <= @ReportGenerationDate 
    AND (tv.ValidTo IS NULL OR tv.ValidTo > @ReportGenerationDate)
    AND tv.IsActive = 1
    ORDER BY tv.ValidFrom DESC;
END;

-- ============================================
-- نمونه Data Inserts
-- ============================================

-- درج تم پایه
INSERT INTO ThemeVersions (VersionName, ValidFrom, ThemeData, CreatedBy, IsActive)
VALUES (
    'Default-Light-v1.0',
    '2025-01-01',
    '{
        "name": "Light Theme",
        "colors": {
            "primary": "#007ACC",
            "secondary": "#F3F3F3",
            "text": "#333333"
        },
        "fonts": {
            "body": {"family": "Segoe UI", "size": 12},
            "heading": {"family": "Segoe UI", "size": 18, "bold": true}
        },
        "branding": {
            "logoUrl": "/logo.png",
            "companyName": "Stimulsoft"
        }
    }',
    'system',
    1
);

-- درج Override کاربر
INSERT INTO UserThemeOverrides (UserId, OverrideData)
VALUES (
    123,
    '{
        "colors": {
            "primary": "#FF5722"
        }
    }'
);
