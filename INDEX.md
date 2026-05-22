<div dir="rtl" align="right">

# 📚 نقشه راه منابع - معماری هیبریدی Stimulsoft

راهنمای کامل برای مطالعه و پیاده‌سازی معماری هیبریدی گزارش‌سازی

---

## 🎯 شروع سریع

### برای مدیران و Decision Makers

1. **خلاصه اجرایی** → [README.md#۱-خلاصه-اجرایی](./README.md#۱-خلاصه-اجرایی-executive-summary)
2. **نتیجه کلیدی** → [README.md#نتیجه-کلیدی-تحقیق](./README.md#🏆-نتیجه-کلیدی-تحقیق)
3. **ماتریس تصمیم‌گیری** → [README.md#۶-ماتریس-تصمیم‌گیری-نهایی](./README.md#۶-ماتریس-تصمیم‌گیری-نهایی)
4. **توصیه نهایی** → [README.md#۷-توصیه-نهایی-معماری](./README.md#۷-توصیه-نهایی-معماری--بهبود‌های-فنی)

⏱️ **زمان مطالعه:** ۱۵-۲۰ دقیقه

---

### برای معماران و تیم فنی

1. **تمام سند** → [README.md](./README.md)
2. **نظرات فنی جامع** → [TECHNICAL_FEEDBACK.md](./TECHNICAL_FEEDBACK.md)
3. **نمونه‌های عملی** → [examples/README.md](./examples/README.md)
4. **Quick Start** → [روند پیاده‌سازی](#-روند-پیاده‌سازی-مرحله‌به‌مرحله)

⏱️ **زمان مطالعه:** ۲-۳ ساعت

---

### برای برنامه‌نویسان

1. **نمونه C#** → [examples/csharp/ReportThemeManager.cs](./examples/csharp/ReportThemeManager.cs)
2. **SQL Schema** → [examples/sql/ThemeDatabase.sql](./examples/sql/ThemeDatabase.sql)
3. **MRT Template** → [examples/xml/neutral_invoice.mrt](./examples/xml/neutral_invoice.mrt)
4. **JSON Theme** → [examples/json/corporate-blue-v2.json](./examples/json/corporate-blue-v2.json)

⏱️ **زمان مطالعه:** ۲-۴ ساعت

---

## 📂 ساختار فایل‌ها

```
Stimulsoft/
├── README.md                    # سند اصلی معماری
├── TECHNICAL_FEEDBACK.md        # نظرات و بهبود‌های فنی
├── CHANGELOG.md                 # تاریخچه تغییرات
├── INDEX.md                     # این فایل
│
└── examples/                    # نمونه‌های عملی
    ├── README.md                # راهنمای examples
    ├── csharp/
    │   └── ReportThemeManager.cs    # Theme Engine بهبود‌یافته
    ├── sql/
    │   └── ThemeDatabase.sql        # Database Schema
    ├── xml/
    │   └── neutral_invoice.mrt      # MRT Template خنثی
    └── json/
        └── corporate-blue-v2.json   # تم JSON جامع
```

---

## 🚀 روند پیاده‌سازی مرحله‌به‌مرحله

### مرحله ۱: درک معماری (۳۰ دقیقه)

**اهداف:**
- فهم تفاوت بین MRT، Code-first و Hybrid
- شناخت مزایا و معایب هر روش

**منابع:**
- [README.md#۳-سه-معماری-اصلی](./README.md#۳-سه-معماری-اصلی-گزارش‌سازی)
- [TECHNICAL_FEEDBACK.md](./TECHNICAL_FEEDBACK.md)

**تمرین:**
- بررسی نمودار معماری (ASCII Art)
- مقایسه جداول مزایا/معایب

---

### مرحله ۲: پلان‌گذاری (۱ ساعت)

**اهداف:**
- تعیین معماری برای پروژه شما
- تدوین Roadmap پیاده‌سازی

**منابع:**
- [README.md#۵-مهم‌ترین-عامل-تصمیم‌گیری](./README.md#۵-مهم‌ترین-عامل-تصمیم‌گیری-واقعی)
- [README.md#۹۵-چک‌لیست-تصمیم‌گیری](./README.md#۹۵-چک‌لیست-تصمیم‌گیری-سریع)
- [TECHNICAL_FEEDBACK.md#priority-roadmap](./TECHNICAL_FEEDBACK.md#priority-roadmap)

**تمرین:**
- تکمیل چک‌لیست تصمیم‌گیری
- نوشتن Requirements Document

---

### مرحله ۳: راه‌اندازی Database (۲ ساعت)

**اهداف:**
- ایجاد Schema Database
- تعریف Stored Procedures

**منابع:**
- [examples/sql/ThemeDatabase.sql](./examples/sql/ThemeDatabase.sql)

**دستورات:**
```bash
# SQL Server
sqlcmd -S your_server -U your_user -P your_password \
  -i examples/sql/ThemeDatabase.sql

# یا برای MySQL
mysql -u user -p database < examples/sql/ThemeDatabase.sql
```

**تست:**
```sql
-- تست جداول
SELECT * FROM ThemeVersions;
SELECT * FROM UserThemeOverrides;

-- تست Stored Procedure
EXEC sp_GetEffectiveTheme @UserId = NULL;
```

---

### مرحله ۴: توسعه C# (۴ ساعت)

**اهداف:**
- پیاده‌سازی ReportThemeManager
- تهیه Unit Tests

**منابع:**
- [examples/csharp/ReportThemeManager.cs](./examples/csharp/ReportThemeManager.cs)
- [TECHNICAL_FEEDBACK.md#۱-معماری-theme-engine](./TECHNICAL_FEEDBACK.md#1️⃣-معماری-theme-engine)

**مراحل:**
```csharp
// ۱. Copy کلاس‌ها
// ۲. تنظیم Dependencies
services.AddScoped<IReportThemeManager, ReportThemeManager>();

// ۳. تست
var theme = await themeManager.GetEffectiveThemeAsync(userId: 1);
```

---

### مرحله ۵: طراحی MRT Templates (۳-۴ ساعت)

**اهداف:**
- ایجاد Neutral Templates
- بدون Styling

**منابع:**
- [examples/xml/neutral_invoice.mrt](./examples/xml/neutral_invoice.mrt)
- [README.md#۹۲-نمونه-neutral-mrt](./README.md#۹۲-نمونه-mrt-خنثی-neutral-template)

**دستور‌العمل:**
- فقط Layout و Data Binding
- بدون رنگ، فونت یا استایل
- استفاده از Placeholder‌ها برای Branding

---

### مرحله ۶: پیکربندی Theme JSON (۲ ساعت)

**اهداف:**
- طراحی Theme جامع
- تعریف رنگ، فونت و Branding

**منابع:**
- [examples/json/corporate-blue-v2.json](./examples/json/corporate-blue-v2.json)
- [TECHNICAL_FEEDBACK.md#۸-version-control-best-practices](./TECHNICAL_FEEDBACK.md#8️⃣-version-control-best-practices)

---

### مرحله ۷: تست و بهینه‌سازی (۳-۴ ساعت)

**اهداف:**
- Unit Tests
- Integration Tests
- Performance Testing

**منابع:**
- [TECHNICAL_FEEDBACK.md#۵-testing-strategy](./TECHNICAL_FEEDBACK.md#5️⃣-testing-strategy)

**مثال:**
```csharp
[TestMethod]
public async Task GetEffectiveTheme_ShouldReturnCachedTheme()
{
    // Arrange, Act, Assert
}
```

---

### مرحله ۸: مستندسازی و تدریس (۱-۲ ساعت)

**اهداف:**
- نوشتن دستورالعمل
- تدریس به تیم

**ارائه‌ها:**
- معماری و تصمیمات
- استفاده از نمونه‌ها
- Troubleshooting

---

## 📊 تایم‌لاین کل

| فاز | زمان |
|:---|:---|
| ۱. درک معماری | ۳۰ دقیقه |
| ۲. پلان‌گذاری | ۱ ساعت |
| ۳. Database | ۲ ساعت |
| ۴. C# Development | ۴ ساعت |
| ۵. MRT Templates | ۳-۴ ساعت |
| ۶. Theme Config | ۲ ساعت |
| ۷. Testing | ۳-۴ ساعت |
| ۸. Documentation | ۱-۲ ساعت |
| **کل** | **۱۶-۲۰ ساعت** |

---

## ✅ چک‌لیست پیاده‌سازی

### پیش‌نیازها
- [ ] SQL Server (یا MySQL)
- [ ] Visual Studio (یا Rider)
- [ ] Stimulsoft Designer
- [ ] Git/Version Control

### مرحله ۱: Setup
- [ ] دریافت تمام فایل‌ها
- [ ] مطالعه README.md
- [ ] مطالعه TECHNICAL_FEEDBACK.md

### مرحله ۲: Database
- [ ] اجرای SQL Script
- [ ] تست جداول
- [ ] تست Stored Procedures

### مرحله ۳: Development
- [ ] Copy کلاس‌های C#
- [ ] تنظیم Dependencies
- [ ] اجرای Unit Tests
- [ ] تست Integration

### مرحله ۴: Templates
- [ ] ایجاد Neutral Templates
- [ ] تست Data Binding
- [ ] تست Runtime Rendering

### مرحله ۵: Themes
- [ ] ایجاد Theme JSON
- [ ] تست Theme Application
- [ ] تست User Overrides

### مرحله ۶: Testing
- [ ] Unit Tests
- [ ] Integration Tests
- [ ] Performance Tests
- [ ] Regression Tests

### مرحله ۷: Deployment
- [ ] تمام کدها در Git
- [ ] Documentation کامل
- [ ] تدریس به تیم
- [ ] Go Live

---

## 💡 نکات مهم

### هنگام پیاده‌سازی

1. **شروع کوچک:** یک گزارش ساده شروع کنید
2. **تست مرتب:** Unit Tests از ابتدا
3. **Version Control:** تمام تغییرات در Git
4. **Documentation:** مستندات همزمان
5. **Performance:** Caching از ابتدا

### موارد یقینی

- ✅ مطمئن شوید Theme Engine Async است
- ✅ Caching تمام اجرا شده‌ است
- ✅ Audit Log فعال است
- ✅ Error Handling جامع است
- ✅ Unit Tests موجود است

### موارد ممکن

- ⚠️ Performance Issues اگر بدون Caching
- ⚠️ Data Loss اگر بدون Audit Trail
- ⚠️ Security Issues اگر بدون Tenant Isolation
- ⚠️ Debugging سخت اگر بدون Logging

---

## 📞 پشتیبانی و سؤالات

### برای سؤالات معماری
- مراجعه به [README.md](./README.md)
- مراجعه به [TECHNICAL_FEEDBACK.md](./TECHNICAL_FEEDBACK.md)

### برای کدهای نمونه
- مراجعه به [examples/README.md](./examples/README.md)
- بررسی کامنت‌های داخل فایل‌ها

### برای مشاکل
- بررسی Troubleshooting Guide
- بررسی Logs
- تست Stored Procedures

---

## 📈 بعدی

بعد از موفق پیاده‌سازی:

1. **توسعه:** Templates و Themes بیشتری
2. **Optimization:** Performance Tuning
3. **Scaling:** Multi-tenant Support
4. **AI Integration:** استفاده از Stimul AI برای طراحی

---

<div align="center">

## 🎉 خوش‌آمدید!

شما می‌توانید یک معماری درجه‌ Enterprise طراحی و پیاده‌سازی کنید.

**سفر خوبی داشته باشید! 🚀**

---

آخرین بروزرسانی: ۲۲ اردیبهشت ۱۴۰۵
