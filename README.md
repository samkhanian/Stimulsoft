<div dir="rtl" align="right">

# 📊 سند راهبرد معماری گزارش‌سازی در Stimulsoft

### تحلیل نهایی معماری، نقش هوش مصنوعی و چارچوب تصمیم‌گیری سازمانی

---

<div align="center">

| 📋 **شناسنامه سند** | |
|:---:|:---|
| **نسخه** | ۲.۱ (ویرایش نهایی) |
| **تاریخ** | ۲ خرداد ۱۴۰۵ |
| **وضعیت** | نهایی – نسخه تصمیم‌سازی معماری |
| **مخاطب** | معمار نرم‌افزار، تیم بک‌اند، مدیر فنی، تیم BI |

</div>

---

## 📑 فهرست مطالب

- [۱. خلاصه اجرایی](#۱-خلاصه-اجرایی-executive-summary)
- [۲. مسئله اصلی معماری گزارش‌سازی](#۲-مسئله-اصلی-معماری-گزارش‌سازی)
- [۳. سه معماری اصلی گزارش‌سازی](#۳-سه-معماری-اصلی-گزارش‌سازی)
  - [۳.۱ معماری مبتنی بر MRT](#۳۱-معماری-مبتنی-بر-mrt-designer-first)
  - [۳.۲ معماری Code-first](#۳۲-معماری-code-first)
  - [۳.۳ معماری هیبریدی](#۳۳-معماری-هیبریدی-پیشنهاد-نهایی)
- [۴. نقش واقعی هوش مصنوعی](#۴-نقش-واقعی-هوش-مصنوعی)
  - [۴.۰ تاریخچه و بلوغ Stimul AI](#۴۰-تاریخچه-و-بلوغ-stimul-ai)
  - [۴.۱ Stimul AI (داخلی)](#۴۱-stimul-ai-هوش-مصنوعی-داخلی)
  - [۴.۲ مدل‌های عمومی AI](#۴۲-مدل‌های-عمومی-ai)
- [۵. مهم‌ترین عامل تصمیم‌گیری](#۵-مهم‌ترین-عامل-تصمیم‌گیری-واقعی)
- [۶. ماتریس تصمیم‌گیری نهایی](#۶-ماتریس-تصمیم‌گیری-نهایی)
- [۷. توصیه نهایی معماری](#۷-توصیه-نهایی-معماری)
- [۸. نتیجه نهایی](#۸-نتیجه-نهایی-نهایی)
- [۹. پیوست: نمونه کدهای مرجع](#۹-پیوست-نمونه-کدهای-مرجع-برای-معماری-هیبریدی)

---

## ۱. خلاصه اجرایی (Executive Summary)

> **این سند با هدف تعیین بهترین استراتژی معماری گزارش‌سازی در اکوسیستم Stimulsoft تهیه شده است.**

تحقیق نشان می‌دهد انتخاب بین:

- 🎨 طراحی مبتنی بر فایل‌های `MRT`
- 💻 کدنویسی مستقیم (`Code-first`)
- ⚡ یا معماری هیبریدی

**فقط یک انتخاب فنی نیست**، بلکه تصمیمی درباره:

- 👥 ساختار تیم
- 🔧 مدل نگهداری
- 👤 نقش کاربران نهایی
- 📜 نیازهای تاریخی و Audit
- 📈 قابلیت توسعه بلندمدت
- 🤖 نحوه استفاده از هوش مصنوعی

---

### 🏆 نتیجه کلیدی تحقیق

<div align="center">

## برای اکثر نرم‌افزارهای سازمانی جدی:

# ⚡ بهترین انتخاب = معماری هیبریدی (Hybrid)

### `MRT` به‌عنوان Skeleton/Layout + مدیریت متمرکز منطق و استایل توسط کد

</div>

---

### 🤖 نتیجه کلیدی درباره هوش مصنوعی

<div align="center">

## بهترین AI برای اکوسیستم Stimulsoft:

# 🧠 خودِ Stimul AI (هوش مصنوعی داخلی)

</div>

| ✅ مزایا | ❌ اما مدل‌های عمومی مثل ChatGPT و Claude... |
|:---|:---|
| ساختار MRT را به‌صورت Native می‌شناسد | برای تولید مستقیم فایل MRT قابل اتکا نیستند |
| مستقیماً در Designer کار می‌کند | برای طراحی کامل گزارش مناسب نیستند |
| خروجی معتبر تولید می‌کند | — |
| با مدل شیء داخلی موتور گزارش هماهنگ است | — |

<div align="center">

### اما مدل‌های عمومی در این موارد **بسیار قدرتمند** هستند:

✨ تولید کد C# &nbsp;&nbsp;|&nbsp;&nbsp; 🏗️ طراحی معماری &nbsp;&nbsp;|&nbsp;&nbsp; 🎨 تولید Theme JSON &nbsp;&nbsp;|&nbsp;&nbsp; 🧩 ساخت Component Builder

</div>

---

## ۲. مسئله اصلی معماری گزارش‌سازی

> **در سیستم‌های سازمانی، گزارش صرفاً «خروجی چاپی» نیست.**

گزارش معمولاً:

- 📄 سند حقوقی
- 💰 سند مالی
- 🔍 سند Audit
- 📸 Snapshot تاریخی
- 🏢 نمای رسمی سازمان
- 🎨 بخشی از هویت بصری سیستم

---

### نیازمندی‌های کلیدی معماری گزارش‌سازی

| نیاز | توضیح |
|:---|:---|
| 🔄 **Dynamic Rendering** | ساختار گزارش در زمان اجرا تغییر کند |
| 🎨 **Centralized Styling** | تم و استایل متمرکز مدیریت شود |
| ⏳ **Historical Reproduction** | ظاهر گزارش در گذشته قابل بازتولید باشد |
| 🏢 **Multi-tenant Branding** | هر شعبه/مشتری تم اختصاصی داشته باشد |
| 🔧 **Maintainability** | نگهداری بلندمدت ممکن باشد |
| 🤖 **AI-assisted Development** | از هوش مصنوعی بهره ببرد |
| 📝 **Versionability** | تغییرات قابل رهگیری و نسخه‌بندی باشند |

---

## ۳. سه معماری اصلی گزارش‌سازی

---

### ۳.۱. معماری مبتنی بر MRT (Designer-first)

> **تعریف:** گزارش توسط Report Designer طراحی می‌شود و خروجی به‌صورت فایل `MRT` ذخیره می‌گردد.

#### ✅ مزایا

| # | مزیت | شرح |
|:---:|:---|:---|
| ۱ | 🖱️ **طراحی سریع بصری** | Drag & Drop، طراحی بدون کدنویسی، مناسب تیم BI |
| ۲ | 👥 **مناسب کاربران غیر برنامه‌نویس** | Business User یا Report Designer مستقل کار می‌کند |
| ۳ | 🤖 **بهترین سازگاری با Stimul AI** | هوش مصنوعی داخلی برای همین Workflow طراحی شده |
| ۴ | ⚡ **توسعه سریع گزارش‌های کلاسیک** | فاکتور، لیست، فرم، گزارش جدولی |

#### ❌ معایب

| # | عیب | شرح |
|:---:|:---|:---|
| ۱ | 📝 **مشکل Version Control** | فایل XML: Diff ناخوانا، Merge conflict شدید |
| ۲ | 📈 **نگهداری سخت در مقیاس بالا** | تغییر فونت سازمانی = ویرایش صدها MRT |
| ۳ | 🔄 **ضعف در Dynamic Layout** | ستون‌های داینامیک، ساختار runtime سخت می‌شود |
| ۴ | ⏳ **Historical Reproduction ضعیف** | بازسازی ظاهر دقیق گزارش‌های گذشته دشوار |

---

### ۳.۲. معماری Code-first

> **تعریف:** تمام ساختار گزارش توسط کد C# ساخته می‌شود.

#### ✅ مزایا

| # | مزیت | شرح |
|:---:|:---|:---|
| ۱ | 🔄 **حداکثر انعطاف‌پذیری** | تمام اجزا runtime ساخته می‌شوند |
| ۲ | 📝 **سازگاری عالی با Git** | کد: diffable، reviewable، testable |
| ۳ | 🧪 **Testability بسیار بالا** | Unit Test، Snapshot Test، Regression Test |
| ۴ | ⏳ **Historical Reproduction واقعی** | تم و ساختار version می‌شود |
| ۵ | 🏢 **مناسب Enterprise** | Multi-tenant، White-label، Dynamic systems |

#### ❌ معایب

| # | عیب | شرح |
|:---:|:---|:---|
| ۱ | 📐 **پیچیدگی Layout Engine** | pagination، overflow، spacing، RTL باید کدنویسی شود |
| ۲ | 📈 **افزایش Technical Debt** | alignment bug، style drift در طول زمان |
| ۳ | 🎓 **نیاز به تخصص بالا** | تسلط C#، شناخت عمیق موتور Stimulsoft |
| ۴ | 🤖 **عدم استفاده از Stimul AI** | هوش مصنوعی داخلی عملاً بی‌استفاده می‌شود |

---

### ۳.۳. معماری هیبریدی (پیشنهاد نهایی) ⚡

> **تعریف:** ترکیب MRT به‌عنوان Skeleton + Code به‌عنوان Runtime Orchestrator

---

#### 🎯 ایده اصلی

<div align="center">

## MRT فقط Layout خام باشد

### و رنگ، فونت، spacing، branding، logo و conditional style در runtime اعمال شوند

</div>

---

#### 🏗️ معماری پیشنهادی

```text
[MRT Neutral Template]
           ↓
[Runtime Theme Engine]
           ↓
[Theme JSON / DB]
           ↓
[User Overrides]
           ↓
[Historical Version Resolver]
           ↓
[Final Render]
✅ مزایا
#	مزیت
۱	⚖️ بهترین تعادل بین Visual Design و Dynamic Rendering
۲	🤖 استفاده همزمان از Stimul AI و AIهای عمومی
۳	📉 کاهش Technical Debt
۴	⏳ پشتیبانی از Historical Rendering
۵	🏢 مناسب Enterprise واقعی
⚠️ مهم‌ترین اصل Hybrid: Single Source of Truth
مسئولیت	محل مدیریت
🔤 Typography	Theme Engine
🎨 Colors	Theme Engine
📐 Layout Structure	MRT
⚙️ Business Logic	Code
👁️ Dynamic Visibility	Code
👤 User Override	DB
❗ اگر این مرزبندی مشخص نباشد، سیستم به chaos تبدیل می‌شود.

۴. نقش واقعی هوش مصنوعی
۴.۰. تاریخچه و بلوغ Stimul AI 🆕
<div align="center">
📅 بازه زمانی	🔔 رویداد
اوایل ۲۰۲۴	اولین نشانه‌های قابلیت‌های AI در ویرایشگر توابع (آزمایشی)
اواخر ۲۰۲۴	🚀 راه‌اندازی رسمی Stimul AI در نسخه ۲۰۲۴.۴
سال ۲۰۲۵	📈 سال تثبیت و گسترش: ترجمه خودکار، عیب‌یابی پیشرفته، ویرایش چت‌محور
</div>
نتیجه: Stimul AI یک فناوری نوپا اما به سرعت در حال تکامل است. سرمایه‌گذاری بر روی معماری که از این قابلیت بهره ببرد (معماری هیبریدی)، یک تصمیم آینده‌نگرانه است.

۴.۱. Stimul AI (هوش مصنوعی داخلی)
🎯 بهترین ابزار برای:
🏗️ ساخت اولیه MRT

📐 تولید Layout

📄 ساخت گزارش‌های استاندارد

🧪 ایجاد Mock Data

🗄️ کمک در SQL

🌐 ترجمه و Localization

🏆 مزیت اصلی
چون مدل داخلی Stimulsoft است، object model را می‌شناسد و schema MRT را می‌فهمد. پس خروجی معتبر تولید می‌کند.

⚠️ محدودیت
Stimul AI یک Design Assistant تخصصی است، نه معمار نرم‌افزار. منطق enterprise و Theme Engine طراحی نمی‌کند.

۴.۲. مدل‌های عمومی AI
<div align="center">
ChatGPT • Claude • Gemini
</div>
کاربرد	وضعیت
💻 تولید کد C#	⭐ عالی
🏗️ طراحی Theme Engine	⭐ عالی
📐 طراحی معماری	⭐ عالی
🎨 تولید JSON Theme	⭐ عالی
📄 تولید MRT معتبر	❌ ضعیف
🖼️ طراحی نهایی گزارش	❌ ضعیف
🤖 نتیجه نهایی AI
سناریو	بهترین AI
🎨 طراحی MRT	🧠 Stimul AI
🏗️ توسعه معماری	🌐 ChatGPT / Claude
💻 تولید کد Runtime	🌐 ChatGPT / Claude
🔄 Dynamic Reporting	🌐 AIهای عمومی
📐 Layout Generation	🧠 Stimul AI
۵. مهم‌ترین عامل تصمیم‌گیری واقعی
<div align="center">
سؤال اصلی این نیست:
«کدام روش بهتر است؟»
سؤال واقعی این است:
«چه کسی مالک گزارش‌هاست؟»
مالک گزارش	معماری پیشنهادی
👔 Business / Designer	🎨 MRT
⚙️ تیم Backend / Architecture	💻 Code-first یا ⚡ Hybrid
</div>
۶. ماتریس تصمیم‌گیری نهایی
نیاز	🎨 MRT	💻 Code-first	⚡ Hybrid
⚡ طراحی سریع	⭐ عالی	❌ ضعیف	✅ خوب
🔄 Dynamic Layout	➖ متوسط	⭐ عالی	⭐ عالی
🔧 نگهداری بلندمدت	➖ متوسط	✅ خوب	⭐ عالی
⏳ Historical Rendering	❌ ضعیف	⭐ عالی	⭐ عالی
🏢 Multi-tenant Theme	❌ ضعیف	⭐ عالی	⭐ عالی
📝 Git Friendly	❌ ضعیف	⭐ عالی	✅ خوب
🤖 استفاده از Stimul AI	⭐ عالی	❌ ندارد	⭐ عالی
🏢 مناسب Enterprise	➖ متوسط	✅ خوب	⭐ عالی
👥 مناسب تیم BI	⭐ عالی	❌ ضعیف	✅ خوب
👨‍💻 مناسب تیم فنی کوچک	➖ متوسط	✅ خوب	⭐ عالی
۷. توصیه نهایی معماری
<div align="center">
اگر پروژه شما:
✅	ویژگی
🏢	سازمانی
📈	بلندمدت
🎨	دارای برندینگ
⏳	دارای نیاز تاریخی
🏢	دارای چند مشتری/شعبه
🔍	دارای Audit
🔄	Dynamic Layout
⚡ معماری پیشنهادی نهایی:
🏆 Hybrid Architecture
🧱 ساختار پیشنهادی
#	جزء
۱	📄 Neutral MRT Templates (فقط Layout)
۲	🎨 ReportThemeManager (موتور مرکزی استایل)
۳	🗄️ Theme Store (JSON + DB Versioning)
۴	💉 Runtime Style Injection
۵	🧩 Component-based Rendering
۶	⏳ Historical Snapshot Support
</div>
۸. نتیجه نهایی نهایی
<div align="center">
معماری	مناسب برای
🎨 Pure MRT	گزارش‌های کلاسیک، تیم‌های BI، طراحی سریع
💻 Pure Code	سیستم‌های شدیداً داینامیک، معماری‌های خاص
⚡ Hybrid	🏆 تقریباً تمام Enterprise Appهای جدی
📝 جمله نهایی تحقیق
«در پروژه‌های مدرن سازمانی، فایل MRT نباید مرکز معماری باشد؛
بلکه باید به یک Skeleton قابل تزریق توسط موتور مرکزی گزارش‌سازی تبدیل شود.»
</div>
۹. پیوست: نمونه کدهای مرجع برای معماری هیبریدی
۹.۱. نمونه کلاس ReportThemeManager
csharp
public class ReportThemeManager
{
    private readonly string _baseThemePath = "Themes/base_theme.json";
    private readonly ApplicationDbContext _db;

    public ReportThemeManager(ApplicationDbContext db)
    {
        _db = db;
    }

    public ReportTheme GetEffectiveTheme(int? userId = null, DateTime? historicalDate = null)
    {
        // ۱. لود تم پایه از JSON
        var theme = JsonConvert.DeserializeObject<ReportTheme>(File.ReadAllText(_baseThemePath));

        // ۲. اعمال اوررایدهای کاربر
        if (userId.HasValue)
        {
            var userOverrides = _db.UserThemeOverrides
                .FirstOrDefault(u => u.UserId == userId.Value);
            if (userOverrides != null)
                theme.ApplyOverrides(userOverrides);
        }

        // ۳. بازتولید تاریخی
        if (historicalDate.HasValue)
        {
            var historicalTheme = _db.ThemeVersions
                .Where(t => t.ValidFrom <= historicalDate.Value)
                .OrderByDescending(t => t.ValidFrom)
                .FirstOrDefault();
            if (historicalTheme != null)
                theme = historicalTheme.ThemeData;
        }

        return theme;
    }
}
۹.۲. نمونه Neutral MRT Template (فایل خنثی)
xml
<!-- neutral_invoice.mrt (نمونه مفهومی) -->
<Report>
  <ReportPage>
    <PageHeaderBand Name="HeaderBand">
      <!-- این باند در runtime با لوگو و سربرگ از Theme Engine پر می‌شود -->
    </PageHeaderBand>
    <DataBand Name="ItemsBand">
      <!-- ستون‌ها و فیلدها، اما بدون رنگ و فونت -->
    </DataBand>
    <PageFooterBand Name="FooterBand">
      <!-- فوتر داینامیک -->
    </PageFooterBand>
  </ReportPage>
</Report>
۹.۳. جدول دیتابیس پیشنهادی
sql
CREATE TABLE ThemeVersions (
    Id INT PRIMARY KEY IDENTITY,
    VersionName NVARCHAR(100),
    ValidFrom DATETIME NOT NULL,
    ThemeData NVARCHAR(MAX), -- JSON کامل تم
    CreatedBy NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE UserThemeOverrides (
    Id INT PRIMARY KEY IDENTITY,
    UserId INT NOT NULL,
    OverrideData NVARCHAR(MAX), -- JSON شامل فقط فیلدهای تغییر یافته
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);
۹.۴. چک‌لیست تصمیم‌گیری سریع
سوال	اگر پاسخ "بله" است
👥 آیا یک طراح گزارش تمام‌وقت دارید؟	🎨 روش MRT را جدی بگیرید
👤 آیا کاربر نهایی باید گزارش بسازد؟	🎨 روش MRT الزامی است
🔄 آیا ساختار گزارش در زمان اجرا کاملاً تغییر می‌کند؟	⚡ Hybrid یا 💻 Code-first
⏳ آیا نیاز به بازتولید گزارش با ظاهر گذشته دارید؟	💻 Code-first یا ⚡ Hybrid
🏢 آیا سیستم چندمشترکه (Multi-tenant) است؟	⚡ Hybrid
👨‍💻 آیا تیم شما فقط برنامه‌نویس است؟	⚡ Hybrid با MRTهای خنثی
🤖 آیا می‌خواهید از هوش مصنوعی برای طراحی سریع استفاده کنید؟	🧠 Stimul AI + 🎨 MRT
<div align="center">
⏻ پایان سند ⏻

تهیه شده با ❤️ برای تیم‌های فنی و معماران نرم‌افزار

</div></div> ```
فایل بالا کاملاً راست‌چین و بهینه‌شده برای نمایش در گیت‌هاب است. کافی است آن را با نام README.md در مخزن خود ذخیره کنید.

از یک جا به بعد از مارکداون خارج شد و قابل کپی کردن یک جا نیست
متوجه شدم. مشکل اینجاست که فرمت مارکداون در پاسخ قبلی شکسته شده و نمی‌توانید یکجا کپی کنید.

بهتر است فایل را به صورت یک بلاک کد کامل و یکپارچه دریافت کنید تا مستقیماً آن را کپی کرده و با نام README.md ذخیره کنید.

در اینجا کل سند در یک بلاک کد ارائه می‌شود. می‌توانید روی دکمه "کپی" در گوشه بالا-راست همین بلاک کلیک کنید تا کل محتوا یکجا کپی شود:

markdown
<div dir="rtl" align="right">

# 📊 سند راهبرد معماری گزارش‌سازی در Stimulsoft

### تحلیل نهایی معماری، نقش هوش مصنوعی و چارچوب تصمیم‌گیری سازمانی

---

<div align="center">

| 📋 **شناسنامه سند** | |
|:---:|:---|
| **نسخه** | ۲.۱ (ویرایش نهایی) |
| **تاریخ** | ۲ خرداد ۱۴۰۵ |
| **وضعیت** | نهایی – نسخه تصمیم‌سازی معماری |
| **مخاطب** | معمار نرم‌افزار، تیم بک‌اند، مدیر فنی، تیم BI |

</div>

---

## 📑 فهرست مطالب

- [۱. خلاصه اجرایی](#۱-خلاصه-اجرایی-executive-summary)
- [۲. مسئله اصلی معماری گزارش‌سازی](#۲-مسئله-اصلی-معماری-گزارش‌سازی)
- [۳. سه معماری اصلی گزارش‌سازی](#۳-سه-معماری-اصلی-گزارش‌سازی)
  - [۳.۱ معماری مبتنی بر MRT](#۳۱-معماری-مبتنی-بر-mrt-designer-first)
  - [۳.۲ معماری Code-first](#۳۲-معماری-code-first)
  - [۳.۳ معماری هیبریدی](#۳۳-معماری-هیبریدی-پیشنهاد-نهایی)
- [۴. نقش واقعی هوش مصنوعی](#۴-نقش-واقعی-هوش-مصنوعی)
  - [۴.۰ تاریخچه و بلوغ Stimul AI](#۴۰-تاریخچه-و-بلوغ-stimul-ai)
  - [۴.۱ Stimul AI (داخلی)](#۴۱-stimul-ai-هوش-مصنوعی-داخلی)
  - [۴.۲ مدل‌های عمومی AI](#۴۲-مدل‌های-عمومی-ai)
- [۵. مهم‌ترین عامل تصمیم‌گیری](#۵-مهم‌ترین-عامل-تصمیم‌گیری-واقعی)
- [۶. ماتریس تصمیم‌گیری نهایی](#۶-ماتریس-تصمیم‌گیری-نهایی)
- [۷. توصیه نهایی معماری](#۷-توصیه-نهایی-معماری)
- [۸. نتیجه نهایی](#۸-نتیجه-نهایی-نهایی)
- [۹. پیوست: نمونه کدهای مرجع](#۹-پیوست-نمونه-کدهای-مرجع-برای-معماری-هیبریدی)

---

## ۱. خلاصه اجرایی (Executive Summary)

> **این سند با هدف تعیین بهترین استراتژی معماری گزارش‌سازی در اکوسیستم Stimulsoft تهیه شده است.**

تحقیق نشان می‌دهد انتخاب بین:

- 🎨 طراحی مبتنی بر فایل‌های `MRT`
- 💻 کدنویسی مستقیم (`Code-first`)
- ⚡ یا معماری هیبریدی

**فقط یک انتخاب فنی نیست**، بلکه تصمیمی درباره:

- 👥 ساختار تیم
- 🔧 مدل نگهداری
- 👤 نقش کاربران نهایی
- 📜 نیازهای تاریخی و Audit
- 📈 قابلیت توسعه بلندمدت
- 🤖 نحوه استفاده از هوش مصنوعی

---

### 🏆 نتیجه کلیدی تحقیق

<div align="center">

## برای اکثر نرم‌افزارهای سازمانی جدی:

# ⚡ بهترین انتخاب = معماری هیبریدی (Hybrid)

### `MRT` به‌عنوان Skeleton/Layout + مدیریت متمرکز منطق و استایل توسط کد

</div>

---

### 🤖 نتیجه کلیدی درباره هوش مصنوعی

<div align="center">

## بهترین AI برای اکوسیستم Stimulsoft:

# 🧠 خودِ Stimul AI (هوش مصنوعی داخلی)

</div>

| ✅ مزایا | ❌ اما مدل‌های عمومی مثل ChatGPT و Claude... |
|:---|:---|
| ساختار MRT را به‌صورت Native می‌شناسد | برای تولید مستقیم فایل MRT قابل اتکا نیستند |
| مستقیماً در Designer کار می‌کند | برای طراحی کامل گزارش مناسب نیستند |
| خروجی معتبر تولید می‌کند | — |
| با مدل شیء داخلی موتور گزارش هماهنگ است | — |

<div align="center">

### اما مدل‌های عمومی در این موارد **بسیار قدرتمند** هستند:

✨ تولید کد C# &nbsp;&nbsp;|&nbsp;&nbsp; 🏗️ طراحی معماری &nbsp;&nbsp;|&nbsp;&nbsp; 🎨 تولید Theme JSON &nbsp;&nbsp;|&nbsp;&nbsp; 🧩 ساخت Component Builder

</div>

---

## ۲. مسئله اصلی معماری گزارش‌سازی

> **در سیستم‌های سازمانی، گزارش صرفاً «خروجی چاپی» نیست.**

گزارش معمولاً:

- 📄 سند حقوقی
- 💰 سند مالی
- 🔍 سند Audit
- 📸 Snapshot تاریخی
- 🏢 نمای رسمی سازمان
- 🎨 بخشی از هویت بصری سیستم

---

### نیازمندی‌های کلیدی معماری گزارش‌سازی

| نیاز | توضیح |
|:---|:---|
| 🔄 **Dynamic Rendering** | ساختار گزارش در زمان اجرا تغییر کند |
| 🎨 **Centralized Styling** | تم و استایل متمرکز مدیریت شود |
| ⏳ **Historical Reproduction** | ظاهر گزارش در گذشته قابل بازتولید باشد |
| 🏢 **Multi-tenant Branding** | هر شعبه/مشتری تم اختصاصی داشته باشد |
| 🔧 **Maintainability** | نگهداری بلندمدت ممکن باشد |
| 🤖 **AI-assisted Development** | از هوش مصنوعی بهره ببرد |
| 📝 **Versionability** | تغییرات قابل رهگیری و نسخه‌بندی باشند |

---

## ۳. سه معماری اصلی گزارش‌سازی

---

### ۳.۱. معماری مبتنی بر MRT (Designer-first)

> **تعریف:** گزارش توسط Report Designer طراحی می‌شود و خروجی به‌صورت فایل `MRT` ذخیره می‌گردد.

#### ✅ مزایا

| # | مزیت | شرح |
|:---:|:---|:---|
| ۱ | 🖱️ **طراحی سریع بصری** | Drag & Drop، طراحی بدون کدنویسی، مناسب تیم BI |
| ۲ | 👥 **مناسب کاربران غیر برنامه‌نویس** | Business User یا Report Designer مستقل کار می‌کند |
| ۳ | 🤖 **بهترین سازگاری با Stimul AI** | هوش مصنوعی داخلی برای همین Workflow طراحی شده |
| ۴ | ⚡ **توسعه سریع گزارش‌های کلاسیک** | فاکتور، لیست، فرم، گزارش جدولی |

#### ❌ معایب

| # | عیب | شرح |
|:---:|:---|:---|
| ۱ | 📝 **مشکل Version Control** | فایل XML: Diff ناخوانا، Merge conflict شدید |
| ۲ | 📈 **نگهداری سخت در مقیاس بالا** | تغییر فونت سازمانی = ویرایش صدها MRT |
| ۳ | 🔄 **ضعف در Dynamic Layout** | ستون‌های داینامیک، ساختار runtime سخت می‌شود |
| ۴ | ⏳ **Historical Reproduction ضعیف** | بازسازی ظاهر دقیق گزارش‌های گذشته دشوار |

---

### ۳.۲. معماری Code-first

> **تعریف:** تمام ساختار گزارش توسط کد C# ساخته می‌شود.

#### ✅ مزایا

| # | مزیت | شرح |
|:---:|:---|:---|
| ۱ | 🔄 **حداکثر انعطاف‌پذیری** | تمام اجزا runtime ساخته می‌شوند |
| ۲ | 📝 **سازگاری عالی با Git** | کد: diffable، reviewable، testable |
| ۳ | 🧪 **Testability بسیار بالا** | Unit Test، Snapshot Test، Regression Test |
| ۴ | ⏳ **Historical Reproduction واقعی** | تم و ساختار version می‌شود |
| ۵ | 🏢 **مناسب Enterprise** | Multi-tenant، White-label، Dynamic systems |

#### ❌ معایب

| # | عیب | شرح |
|:---:|:---|:---|
| ۱ | 📐 **پیچیدگی Layout Engine** | pagination، overflow، spacing، RTL باید کدنویسی شود |
| ۲ | 📈 **افزایش Technical Debt** | alignment bug، style drift در طول زمان |
| ۳ | 🎓 **نیاز به تخصص بالا** | تسلط C#، شناخت عمیق موتور Stimulsoft |
| ۴ | 🤖 **عدم استفاده از Stimul AI** | هوش مصنوعی داخلی عملاً بی‌استفاده می‌شود |

---

### ۳.۳. معماری هیبریدی (پیشنهاد نهایی) ⚡

> **تعریف:** ترکیب MRT به‌عنوان Skeleton + Code به‌عنوان Runtime Orchestrator

---

#### 🎯 ایده اصلی

<div align="center">

## MRT فقط Layout خام باشد

### و رنگ، فونت، spacing، branding، logo و conditional style در runtime اعمال شوند

</div>

---

#### 🏗️ معماری پیشنهادی

```text
[MRT Neutral Template]
           ↓
[Runtime Theme Engine]
           ↓
[Theme JSON / DB]
           ↓
[User Overrides]
           ↓
[Historical Version Resolver]
           ↓
[Final Render]
✅ مزایا
#	مزیت
۱	⚖️ بهترین تعادل بین Visual Design و Dynamic Rendering
۲	🤖 استفاده همزمان از Stimul AI و AIهای عمومی
۳	📉 کاهش Technical Debt
۴	⏳ پشتیبانی از Historical Rendering
۵	🏢 مناسب Enterprise واقعی
⚠️ مهم‌ترین اصل Hybrid: Single Source of Truth
مسئولیت	محل مدیریت
🔤 Typography	Theme Engine
🎨 Colors	Theme Engine
📐 Layout Structure	MRT
⚙️ Business Logic	Code
👁️ Dynamic Visibility	Code
👤 User Override	DB
❗ اگر این مرزبندی مشخص نباشد، سیستم به chaos تبدیل می‌شود.

۴. نقش واقعی هوش مصنوعی
۴.۰. تاریخچه و بلوغ Stimul AI 🆕
<div align="center">
📅 بازه زمانی	🔔 رویداد
اوایل ۲۰۲۴	اولین نشانه‌های قابلیت‌های AI در ویرایشگر توابع (آزمایشی)
اواخر ۲۰۲۴	🚀 راه‌اندازی رسمی Stimul AI در نسخه ۲۰۲۴.۴
سال ۲۰۲۵	📈 سال تثبیت و گسترش: ترجمه خودکار، عیب‌یابی پیشرفته، ویرایش چت‌محور
</div>
نتیجه: Stimul AI یک فناوری نوپا اما به سرعت در حال تکامل است. سرمایه‌گذاری بر روی معماری که از این قابلیت بهره ببرد (معماری هیبریدی)، یک تصمیم آینده‌نگرانه است.

۴.۱. Stimul AI (هوش مصنوعی داخلی)
🎯 بهترین ابزار برای:
🏗️ ساخت اولیه MRT

📐 تولید Layout

📄 ساخت گزارش‌های استاندارد

🧪 ایجاد Mock Data

🗄️ کمک در SQL

🌐 ترجمه و Localization

🏆 مزیت اصلی
چون مدل داخلی Stimulsoft است، object model را می‌شناسد و schema MRT را می‌فهمد. پس خروجی معتبر تولید می‌کند.

⚠️ محدودیت
Stimul AI یک Design Assistant تخصصی است، نه معمار نرم‌افزار. منطق enterprise و Theme Engine طراحی نمی‌کند.

۴.۲. مدل‌های عمومی AI
<div align="center">
ChatGPT • Claude • Gemini
</div>
کاربرد	وضعیت
💻 تولید کد C#	⭐ عالی
🏗️ طراحی Theme Engine	⭐ عالی
📐 طراحی معماری	⭐ عالی
🎨 تولید JSON Theme	⭐ عالی
📄 تولید MRT معتبر	❌ ضعیف
🖼️ طراحی نهایی گزارش	❌ ضعیف
🤖 نتیجه نهایی AI
سناریو	بهترین AI
🎨 طراحی MRT	🧠 Stimul AI
🏗️ توسعه معماری	🌐 ChatGPT / Claude
💻 تولید کد Runtime	🌐 ChatGPT / Claude
🔄 Dynamic Reporting	🌐 AIهای عمومی
📐 Layout Generation	🧠 Stimul AI
۵. مهم‌ترین عامل تصمیم‌گیری واقعی
<div align="center">
سؤال اصلی این نیست:
«کدام روش بهتر است؟»
سؤال واقعی این است:
«چه کسی مالک گزارش‌هاست؟»
مالک گزارش	معماری پیشنهادی
👔 Business / Designer	🎨 MRT
⚙️ تیم Backend / Architecture	💻 Code-first یا ⚡ Hybrid
</div>
۶. ماتریس تصمیم‌گیری نهایی
نیاز	🎨 MRT	💻 Code-first	⚡ Hybrid
⚡ طراحی سریع	⭐ عالی	❌ ضعیف	✅ خوب
🔄 Dynamic Layout	➖ متوسط	⭐ عالی	⭐ عالی
🔧 نگهداری بلندمدت	➖ متوسط	✅ خوب	⭐ عالی
⏳ Historical Rendering	❌ ضعیف	⭐ عالی	⭐ عالی
🏢 Multi-tenant Theme	❌ ضعیف	⭐ عالی	⭐ عالی
📝 Git Friendly	❌ ضعیف	⭐ عالی	✅ خوب
🤖 استفاده از Stimul AI	⭐ عالی	❌ ندارد	⭐ عالی
🏢 مناسب Enterprise	➖ متوسط	✅ خوب	⭐ عالی
👥 مناسب تیم BI	⭐ عالی	❌ ضعیف	✅ خوب
👨‍💻 مناسب تیم فنی کوچک	➖ متوسط	✅ خوب	⭐ عالی
۷. توصیه نهایی معماری
<div align="center">
اگر پروژه شما:
✅	ویژگی
🏢	سازمانی
📈	بلندمدت
🎨	دارای برندینگ
⏳	دارای نیاز تاریخی
🏢	دارای چند مشتری/شعبه
🔍	دارای Audit
🔄	Dynamic Layout
⚡ معماری پیشنهادی نهایی:
🏆 Hybrid Architecture
🧱 ساختار پیشنهادی
#	جزء
۱	📄 Neutral MRT Templates (فقط Layout)
۲	🎨 ReportThemeManager (موتور مرکزی استایل)
۳	🗄️ Theme Store (JSON + DB Versioning)
۴	💉 Runtime Style Injection
۵	🧩 Component-based Rendering
۶	⏳ Historical Snapshot Support
</div>
۸. نتیجه نهایی نهایی
<div align="center">
معماری	مناسب برای
🎨 Pure MRT	گزارش‌های کلاسیک، تیم‌های BI، طراحی سریع
💻 Pure Code	سیستم‌های شدیداً داینامیک، معماری‌های خاص
⚡ Hybrid	🏆 تقریباً تمام Enterprise Appهای جدی
📝 جمله نهایی تحقیق
«در پروژه‌های مدرن سازمانی، فایل MRT نباید مرکز معماری باشد؛
بلکه باید به یک Skeleton قابل تزریق توسط موتور مرکزی گزارش‌سازی تبدیل شود.»
</div>
۹. پیوست: نمونه کدهای مرجع برای معماری هیبریدی
۹.۱. نمونه کلاس ReportThemeManager
csharp
public class ReportThemeManager
{
    private readonly string _baseThemePath = "Themes/base_theme.json";
    private readonly ApplicationDbContext _db;

    public ReportThemeManager(ApplicationDbContext db)
    {
        _db = db;
    }

    public ReportTheme GetEffectiveTheme(int? userId = null, DateTime? historicalDate = null)
    {
        // ۱. لود تم پایه از JSON
        var theme = JsonConvert.DeserializeObject<ReportTheme>(File.ReadAllText(_baseThemePath));

        // ۲. اعمال اوررایدهای کاربر
        if (userId.HasValue)
        {
            var userOverrides = _db.UserThemeOverrides
                .FirstOrDefault(u => u.UserId == userId.Value);
            if (userOverrides != null)
                theme.ApplyOverrides(userOverrides);
        }

        // ۳. بازتولید تاریخی
        if (historicalDate.HasValue)
        {
            var historicalTheme = _db.ThemeVersions
                .Where(t => t.ValidFrom <= historicalDate.Value)
                .OrderByDescending(t => t.ValidFrom)
                .FirstOrDefault();
            if (historicalTheme != null)
                theme = historicalTheme.ThemeData;
        }

        return theme;
    }
}
۹.۲. نمونه Neutral MRT Template (فایل خنثی)
xml
<!-- neutral_invoice.mrt (نمونه مفهومی) -->
<Report>
  <ReportPage>
    <PageHeaderBand Name="HeaderBand">
      <!-- این باند در runtime با لوگو و سربرگ از Theme Engine پر می‌شود -->
    </PageHeaderBand>
    <DataBand Name="ItemsBand">
      <!-- ستون‌ها و فیلدها، اما بدون رنگ و فونت -->
    </DataBand>
    <PageFooterBand Name="FooterBand">
      <!-- فوتر داینامیک -->
    </PageFooterBand>
  </ReportPage>
</Report>
۹.۳. جدول دیتابیس پیشنهادی
sql
CREATE TABLE ThemeVersions (
    Id INT PRIMARY KEY IDENTITY,
    VersionName NVARCHAR(100),
    ValidFrom DATETIME NOT NULL,
    ThemeData NVARCHAR(MAX), -- JSON کامل تم
    CreatedBy NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE UserThemeOverrides (
    Id INT PRIMARY KEY IDENTITY,
    UserId INT NOT NULL,
    OverrideData NVARCHAR(MAX), -- JSON شامل فقط فیلدهای تغییر یافته
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);
۹.۴. چک‌لیست تصمیم‌گیری سریع
سوال	اگر پاسخ "بله" است
👥 آیا یک طراح گزارش تمام‌وقت دارید؟	🎨 روش MRT را جدی بگیرید
👤 آیا کاربر نهایی باید گزارش بسازد؟	🎨 روش MRT الزامی است
🔄 آیا ساختار گزارش در زمان اجرا کاملاً تغییر می‌کند؟	⚡ Hybrid یا 💻 Code-first
⏳ آیا نیاز به بازتولید گزارش با ظاهر گذشته دارید؟	💻 Code-first یا ⚡ Hybrid
🏢 آیا سیستم چندمشترکه (Multi-tenant) است؟	⚡ Hybrid
👨‍💻 آیا تیم شما فقط برنامه‌نویس است؟	⚡ Hybrid با MRTهای خنثی
🤖 آیا می‌خواهید از هوش مصنوعی برای طراحی سریع استفاده کنید؟	🧠 Stimul AI + 🎨 MRT
<div align="center">
⏻ پایان سند ⏻

تهیه شده با ❤️ برای تیم‌های فنی و معماران نرم‌افزار

</div></div>
