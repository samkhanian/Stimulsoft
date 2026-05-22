<div dir="rtl" align="right">

# 📚 نمونه‌های عملی - معماری هیبریدی گزارش‌سازی

این پوشه شامل نمونه‌های کامل و عملی برای پیاده‌سازی معماری هیبریدی در Stimulsoft است.

---

## 📂 ساختار پوشه‌ها

```
examples/
├── csharp/              # کدهای C# مشروح
├── sql/                 # سناریو‌های پایگاه داده
├── xml/                 # نمونه‌های MRT خنثی
├── json/                # تم‌های JSON
└── README.md            # این فایل
```

---

## 🔹 C# Examples (`csharp/`)

### فایل: `ReportThemeManager.cs`

**موضوع:** پیاده‌سازی کامل Theme Engine با بهبود‌های پیشنهادی

**ویژگی‌های اصلی:**
- ✅ **Caching Strategy** - بهبود Performance
- ✅ **Error Handling** - مدیریت استثناها
- ✅ **Async/Await** - عملیات ناهم‌زمان
- ✅ **Dependency Injection** - معماری بهتر
- ✅ **Logging** - پیگیری عملیات

**استفاده:**
```csharp
// ثبت Dependency
services.AddScoped<IReportThemeManager, ReportThemeManager>();

// استفاده
var themeManager = serviceProvider.GetRequiredService<IReportThemeManager>();
var theme = await themeManager.GetEffectiveThemeAsync(
    userId: 123,
    historicalDate: new DateTime(2025, 1, 15)
);
```

**موارد مطالعه‌ای:**
- دریافت تم موثر برای کاربر
- اعمال Override‌های کاربر
- بازتولید تاریخی دقیق
- کشینگ برای بهبود Performance
- Error Handling جامع

---

## 🔹 SQL Examples (`sql/`)

### فایل: `ThemeDatabase.sql`

**موضوع:** طراحی کامل پایگاه داده برای Theme Engine

**جداول:**
- `ThemeVersions` - نسخه‌های تم
- `UserThemeOverrides` - Override‌های کاربر
- `ThemeAuditLog` - ثبت تغییرات
- `TenantThemes` - تم‌های Multi-tenant
- `ReportTemplateBindings` - ربط MRT و Themes

**Stored Procedures:**
- `sp_GetEffectiveTheme` - دریافت تم موثر
- `sp_CreateThemeVersion` - ایجاد نسخه جدید
- `sp_GetHistoricalReportTheme` - دریافت تم تاریخی

**استفاده:**
```sql
-- دریافت تم موثر برای کاربر
EXEC sp_GetEffectiveTheme @UserId = 123, @HistoricalDate = '2025-01-15';

-- ایجاد نسخه جدید تم
EXEC sp_CreateThemeVersion 
    @VersionName = 'Blue-v2.1',
    @ThemeData = N'{...}',
    @CreatedBy = 'admin';
```

**موارد مطالعه‌ای:**
- طراحی Schema برای Historical Tracking
- Audit Trail برای Compliance
- Performance Indexes
- Multi-tenant Support
- Stored Procedures برای عملیات رایج

---

## 🔹 XML Examples (`xml/`)

### فایل: `neutral_invoice.mrt`

**موضوع:** نمونه MRT خنثی (بدون رنگ/فونت)

**خصوصیات:**
- ✅ **فقط Layout** - بدون استایل
- ✅ **Placeholder‌ها** - برای Runtime Injection
- ✅ **RTL Support** - پشتیبانی راست‌به‌چپ
- ✅ **Dynamic Sections** - سکشن‌های قابل تغییر
- ✅ **Data Binding** - ربط داده‌ها

**استفاده:**
```xml
<!-- فایل MRT فقط Layout را تعریف می‌کند -->
<!-- مثال: TextObject با placeholder -->
<TextObject Name="CompanyNamePlaceholder">
  <Text>{{COMPANY_NAME}}</Text>
</TextObject>
```

**موارد مطالعه‌ای:**
- ساختار MRT نادرست برای Hybrid Architecture
- استفاده از Placeholder‌ها برای Runtime Customization
- Binding به Data Sources
- استفاده از Variables و Expressions

---

## 🔹 JSON Examples (`json/`)

### فایل: `corporate-blue-v2.json`

**موضوع:** تم جامع JSON برای اعمال در Runtime

**بخش‌های اصلی:**
- 🎨 **Colors** - رنگ‌های کامل
- 🔤 **Fonts** - تعریف فونت‌ها
- 🏢 **Branding** - لوگو و اطلاعات شرکت
- 📏 **Spacing** - فاصله‌ها و Padding
- 📊 **Tables** - استایل جداول
- 📄 **Headers/Footers** - استایل سربرگ/پاده‌نوشت
- 🌐 **Localization** - پشتیبانی RTL و فرمت‌های محلی

**ساختار:**
```json
{
  "themeName": "Corporate-Blue-v2.0",
  "colors": { ... },
  "fonts": { ... },
  "branding": { ... },
  "tables": { ... },
  ...
}
```

**موارد مطالعه‌ای:**
- طراحی تم جامع برای Enterprise
- مدیریت رنگ‌ها و Typography
- Branding و Company Info
- RTL و Localization
- Print Settings

---

## 🚀 چگونگی استفاده از این نمونه‌ها

### مرحله ۱: درک معماری
1. ابتدا [../../README.md](../../README.md) را بخوانید
2. سپس [../../TECHNICAL_FEEDBACK.md](../../TECHNICAL_FEEDBACK.md) را مطالعه کنید

### مرحله ۲: دیتابیس را راه‌اندازی کنید
```bash
# SQL Server
sqlcmd -S your_server -U your_user -P your_password -i sql/ThemeDatabase.sql
```

### مرحله ۳: کد C# را پیاده‌سازی کنید
```bash
# کلاس‌های C# را به پروژه خود کپی کنید
cp csharp/ReportThemeManager.cs ../../../YourProject/Services/
```

### مرحله ۴: Template‌های MRT را طراحی کنید
```bash
# از neutral_invoice.mrt به عنوان نمونه استفاده کنید
# و Template‌های خود را بر اساس آن بسازید
```

### مرحله ۵: Theme JSON را پیکربندی کنید
```bash
# corporate-blue-v2.json را Custom کنید
# Branding، رنگ‌ها و فونت‌های خود را اضافه کنید
```

---

## 📊 مثال کامل: استفاده یکجا

```csharp
// ۱. Configuration
var themeManager = new ReportThemeManager(dbContext, cache, logger);

// ۲. بارگزاری MRT خنثی
var reportTemplate = LoadMrtTemplate("neutral_invoice.mrt");

// ۳. دریافت تم کاربر
var userTheme = await themeManager.GetEffectiveThemeAsync(
    userId: currentUser.Id,
    historicalDate: null  // تم فعلی
);

// ۴. اعمال Theme در Runtime
var themifiedTemplate = ApplyThemeToTemplate(reportTemplate, userTheme);

// ۵. رندر گزارش
var renderedReport = renderer.Render(themifiedTemplate, data);
```

---

## ✅ تمام کدها فارسی و انگلیسی است

- توضیحات کامل فارسی
- نام متغیرها انگلیسی (برای Best Practice)
- کامنت‌های مفصل

---

## 📚 منابع اضافی

| منبع | توضیح |
|:---|:---|
| [README.md](../../README.md) | سند اصلی معماری |
| [TECHNICAL_FEEDBACK.md](../../TECHNICAL_FEEDBACK.md) | نظرات فنی جامع |
| [Stimulsoft Docs](https://www.stimulsoft.com) | مستندات رسمی |

---

## 💡 نکات مهم

1. **نمونه‌ها آموزشی است** - برای تولید در Production، تطبیق بیشتری لازم است
2. **Error Handling** - مطمئن شوید تمام Exceptions کنترل‌شده‌اند
3. **Performance** - برای تعداد کاربران زیاد، Caching ضروری است
4. **Testing** - Unit Tests و Integration Tests اضافه کنید
5. **Audit** - تمام تغییرات Theme را Log کنید

---

**آخرین بروزرسانی:** ۲۲ اردیبهشت ۱۴۰۵

</div>
