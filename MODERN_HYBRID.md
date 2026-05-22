# 🏛️ معماری هیبریدی مدرن (Angular + .NET + Kendo + Stimulsoft)

این سند ملاحظات فنی و ساختار پیشنهادی برای پیاده‌سازی سیستم گزارش‌سازی و گریدینگ یکپارچه را تشریح می‌کند.

## 🎯 اصول کلیدی معماری

### ۱. تمرکز محاسبات (Centralized Calculation Engine)
بزرگترین خطای سیستم‌های مالی، دوگانگی منطق محاسباتی بین گرید (Front) و گزارش (Back) است. 
- **قاعده:** هیچ فرمول ریاضی یا محاسباتی نباید در فایل `MRT` یا کامپوننت Angular نوشته شود.
- **راه حل:** یک `FinancialCalculationEngine` در لایه Core بک‌ند ایجاد می‌شود که خروجی آن یک **Calculation-Ready DTO** است.

### ۲. مدل داده‌ای مشترک (Shared Data Model)
هم گرید Kendo و هم موتور Stimulsoft از یک مدل داده واحد استفاده می‌کنند.
- **Kendo Grid:** دیتا را به صورت JSON از API دریافت کرده و صرفاً نمایش می‌دهد.
- **Stimulsoft:** همان DTO را به عنوان DataSource دریافت کرده و در قالب Layout تزریق می‌کند.

### ۳. ابزارهای مشترک (Shared Utilities)
محاسباتی مانند تقویم (شمسی/میلادی)، تبدیل نرخ ارز و ... در لایه Infrastructure بک‌ند پیاده‌سازی شده و نتایج نهایی به هر دو ابزار تزریق می‌شود.

---

### ۴. استراتژی محاسبات سه‌لایه (Three-Tier Calculation Logic)

برای بهینه‌سازی پرفورمنس و حفظ دقت، محاسبات به سه دسته تقسیم می‌شوند:

- **لایه دیتابیس (Persisted Totals):** مقادیری که باید ثبت شوند و طراح گزارش در زمان طراحی به عنوان فیلد قطعی از آن‌ها استفاده می‌کند (مانند مانده نهایی تراز).
- **لایه بک‌ند (Orchestrated Logic):** محاسبات پویا که نیاز به Single Source of Truth دارند (مانند تبدیل ارز).
- **لایه فرانت‌بند (UX Calculations):** محاسبات سبک برای نمایش سریع در Kendo Grid که لود سرور را کاهش می‌دهد (مانند جمع ردیف‌های انتخاب شده).

---

## 📂 ساختار پیشنهادی فایل‌ها

### 💻 Backend (.NET Core)
```text
src/Backend/
├── Project.Core/                 # لایه منطق تجاری و محاسبات
│   ├── Calculations/             # موتور محاسبات مالی (جم کل، موجودی و ...)
│   │   ├── IFinancialEngine.cs
│   │   └── TaxCalculator.cs
│   ├── Domain/                   # موجودیت‌ها و تقویم مشترک
│   └── DTOs/                     # مدل‌های انتقال داده (Single Source of Truth)
│       └── FinancialSummaryDto.cs
├── Project.Infrastructure/       # لایه دسترسی به دیتا و ابزارهای پایه
├── Project.Services/             # لایه سرویس‌ها
│   └── Reporting/                # مدیریت گزارشات و تزریق تم به Stimulsoft
└── Project.API/                  # کنترلرها برای تغذیه Angular و Stimulsoft
```

### 🎨 Frontend (Angular)
```text
src/Frontend/
├── src/app/
│   ├── core/                     # سرویس‌های مرکزی برای فراخوانی API
│   ├── shared/                   # کامپوننت‌های مشترک Kendo
│   │   └── components/
│   │       └── data-grid/         # گرید Kendo با تنظیمات پیش‌فرض
│   └── modules/
│       └── reports/               # ماژول گزارشات و ویوئر Stimulsoft
└── assets/
    └── reports/                  # فایل‌های MRT (فقط Layout خنثی)
```

---

## ⚖️ ماتریس مسئولیت‌ها

| ویژگی | محل محاسبه | محل نمایش |
| :--- | :--- | :--- |
| **جمع‌های ثبت شده (Audit)** | Database / Persisted | Stimulsoft & Kendo |
| **محاسبات بیزینس (مالیات و ...)** | Backend (Core) | Stimulsoft & Kendo |
| **جمع‌های لحظه‌ای گرید** | Frontend (Angular) | Kendo UI |
| **منطق تقویم** | Backend (Infra) | Angular & Stimulsoft |
| **استایل و رنگ** | Backend (Theme Engine) | Stimulsoft Injection |
| **چیدمان (Layout)** | Stimulsoft Designer | Stimulsoft Engine |
| **تعامل کاربر** | Angular | Kendo UI |

---

## 🚀 قدم اول: زیربنای کد
قبل از باز کردن Designer یا نوشتن HTML، باید `IFinancialEngine` در بک‌ند طراحی شود تا اطمینان حاصل شود که "جمع کل" در همه جای سیستم یکسان است.

---

## 🗺️ نقشه راه پیاده‌سازی (Implementation Roadmap)

### مرحله ۱: زیرساخت بک‌ند (.NET Core)
- ایجاد لایه Core و تعریف DTOهای مشترک.
- پیاده‌سازی `FinancialEngine` برای محاسبات بیزینس.
- طراحی سیستم مدیریت تم و تزریق استایل به Stimulsoft.

### مرحله ۲: فرانت‌بند (Angular + Kendo)
- پیاده‌سازی سرویس‌های API برای دریافت داده‌های محاسباتی.
- ساخت کامپوننت گرید Kendo با قابلیت Aggregate لحظه‌ای (Front-end calculation).
- یکپارچه‌سازی ویوئر گزارش Stimulsoft.

### مرحله ۳: طراحی گزارشات (MRT Layouts)
- طراحی فایل‌های MRT خنثی (Neutral Layouts) در Designer.
- تست Data Binding با استفاده از DTOهای طراحی شده.

### مرحله ۴: تست و اعتبارسنجی
- تست واحد (Unit Test) برای موتور محاسبات.
- تست یکپارچگی (Integration Test) برای اطمینان از برابری اعداد در گرید و گزارش.

---

## ✅ چک‌لیست نهایی
- [ ] آیا تمام محاسبات مالی در بک‌ند متمرکز شده‌اند؟
- [ ] آیا گرید Kendo و گزارش Stimulsoft از یک DTO واحد استفاده می‌کنند؟
- [ ] آیا منطق تقویم و تبدیل‌های پایه در لایه Infrastructure بک‌ند قرار دارد؟
- [ ] آیا فایل‌های MRT فاقد هرگونه استایل رنگ و فونت هاردکد شده هستند؟
