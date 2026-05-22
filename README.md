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
- [۸. نتیجه نهایی](#۸-نتیجه-نهایی)
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

#### 🎯 ایده اصلی

<div align="center">

## MRT فقط Layout خام باشد

### و رنگ، فونت، spacing، branding، logo و conditional style در runtime اعمال شوند

</div>

---

#### 🏗️ معماری پیشنهادی

```
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
```

#### ✅ مزایا

| # | مزیت |
|:---:|:---|
| ۱ | ⚖️ بهترین تعادل بین Visual Design و Dynamic Rendering |
| ۲ | 🤖 استفاده همزمان از Stimul AI و AIهای عمومی |
| ۳ | 📉 کاهش Technical Debt |
| ۴ | ⏳ پشتیبانی از Historical Rendering |
| ۵ | 🏢 مناسب Enterprise واقعی |

#### ⚠️ مهم‌ترین اصل Hybrid: Single Source of Truth

| مسئولیت | محل مدیریت |
|:---|:---|
| 🔤 Typography | Theme Engine |
| 🎨 Colors | Theme Engine |
| 📐 Layout Structure | MRT |
| ⚙️ Business Logic | Code |
| 👁️ Dynamic Visibility | Code |
| 👤 User Override | DB |

**❗ اگر این مرزبندی مشخص نباشد، سیستم به chaos تبدیل می‌شود.**

---

## ۴. نقش واقعی هوش مصنوعی

### ۴.۰. تاریخچه و بلوغ Stimul AI 🆕

| 📅 بازه زمانی | 🔔 رویداد |
|:---|:---|
| اوایل ۲۰۲۴ | اولین نشانه‌های قابلیت‌های AI در ویرایشگر توابع (آزمایشی) |
| اواخر ۲۰۲۴ | 🚀 راه‌اندازی رسمی Stimul AI در نسخه ۲۰۲۴.۴ |
| سال ۲۰۲۵ | 📈 سال تثبیت و گسترش: ترجمه خودکار، عیب‌یابی پیشرفته، ویرایش چت‌محور |

**نتیجه:** Stimul AI یک فناوری نوپا اما به سرعت در حال تکامل است. سرمایه‌گذاری بر روی معماری که از این قابلیت بهره ببرد (معماری هیبریدی)، یک تصمیم آینده‌نگرانه است.

---

### ۴.۱. Stimul AI (هوش مصنوعی داخلی)

**🎯 بهترین ابزار برای:**

- 🏗️ ساخت اولیه MRT
- 📐 تولید Layout
- 📄 ساخت گزارش‌های استاندارد
- 🧪 ایجاد Mock Data
- 🗄️ کمک در SQL
- 🌐 ترجمه و Localization

**🏆 مزیت اصلی**

چون مدل داخلی Stimulsoft است، object model را می‌شناسد و schema MRT را می‌فهمد. پس خروجی معتبر تولید می‌کند.

**⚠️ محدودیت**

Stimul AI یک Design Assistant تخصصی است، نه معمار نرم‌افزار. منطق enterprise و Theme Engine طراحی نمی‌کند.

---

### ۴.۲. مدل‌های عمومی AI

<div align="center">

**ChatGPT • Claude • Gemini**

</div>

| کاربرد | وضعیت |
|:---|:---|
| 💻 تولید کد C# | ⭐ عالی |
| 🏗️ طراحی Theme Engine | ⭐ عالی |
| 📐 طراحی معماری | ⭐ عالی |
| 🎨 تولید JSON Theme | ⭐ عالی |
| 📄 تولید MRT معتبر | ❌ ضعیف |
| 🖼️ طراحی نهایی گزارش | ❌ ضعیف |

---

### 🤖 نتیجه نهایی AI

| سناریو | بهترین AI |
|:---|:---|
| 🎨 طراحی MRT | 🧠 Stimul AI |
| 🏗️ توسعه معماری | 🌐 ChatGPT / Claude |
| 💻 تولید کد Runtime | 🌐 ChatGPT / Claude |
| 🔄 Dynamic Reporting | 🌐 AIهای عمومی |
| 📐 Layout Generation | 🧠 Stimul AI |

---

## ۵. مهم‌ترین عامل تصمیم‌گیری واقعی

<div align="center">

**سؤال اصلی این نیست:**

«کدام روش بهتر است؟»

**سؤال واقعی این است:**

«چه کسی مالک گزارش‌هاست؟»

| مالک گزارش | معماری پیشنهادی |
|:---|:---|
| 👔 Business / Designer | 🎨 MRT |
| ⚙️ تیم Backend / Architecture | 💻 Code-first یا ⚡ Hybrid |

</div>

---

## ۶. ماتریس تصمیم‌گیری نهایی

| نیاز | 🎨 MRT | 💻 Code-first | ⚡ Hybrid |
|:---|:---:|:---:|:---:|
| ⚡ طراحی سریع | ⭐ عالی | ❌ ضعیف | ✅ خوب |
| 🔄 Dynamic Layout | ➖ متوسط | ⭐ عالی | ⭐ عالی |
| 🔧 نگهداری بلندمدت | ➖ متوسط | ✅ خوب | ⭐ عالی |
| ⏳ Historical Rendering | ❌ ضعیف | ⭐ عالی | ⭐ عالی |
| 🏢 Multi-tenant Theme | ❌ ضعیف | ⭐ عالی | ⭐ عالی |
| 📝 Git Friendly | ❌ ضعیف | ⭐ عالی | ✅ خوب |
| 🤖 استفاده از Stimul AI | ⭐ عالی | ❌ ندارد | ⭐ عالی |
| 🏢 مناسب Enterprise | ➖ متوسط | ✅ خوب | ⭐ عالی |
| 👥 مناسب تیم BI | ⭐ عالی | ❌ ضعیف | ✅ خوب |
| 👨‍💻 مناسب تیم فنی کوچک | ➖ متوسط | ✅ خوب | ⭐ عالی |

---

## ۷. توصیه نهایی معماری + بهبود‌های فنی

<div align="center">

### اگر پروژه شما:

| ✅ | ویژگی |
|:---:|:---|
| 🏢 | سازمانی |
| 📈 | بلندمدت |
| 🎨 | دارای برندینگ |
| ⏳ | دارای نیاز تاریخی |
| 🏢 | دارای چند مشتری/شعبه |
| 🔍 | دارای Audit |
| 🔄 | Dynamic Layout |

### ⚡ معماری پیشنهادی نهایی:

# 🏆 Hybrid Architecture

</div>

---

### 🧱 ساختار پیشنهادی (با بهبود‌های فنی)

| # | جزء | بهبود‌ها |
|:---:|:---|:---|
| ۱ | 📄 Neutral MRT Templates | فقط Layout بدون Styling |
| ۲ | 🎨 ReportThemeManager | ✅ Caching + Async + Error Handling |
| ۳ | 🗄️ Theme Store | ✅ Audit Trail + Historical Support |
| ۴ | 💉 Runtime Style Injection | ✅ Tenant Isolation + Multi-level Overrides |
| ۵ | 🧩 Component-based Rendering | ✅ Factory Pattern + Component Registry |
| ۶ | ⏳ Historical Snapshot Support | ✅ Version Control + Rollback |

---

### 🔑 بهبود‌های کلیدی پیشنهادی

#### ۱. Theme Engine بهبود‌یافته
- **Caching Strategy** - بهبود ۲۰-۳۰% Performance
- **Async/Await** - عملیات ناهم‌زمان
- **Error Handling** - مدیریت Exception‌ها
- **Logging** - پیگیری تمام عملیات

#### ۲. Database Schema بهتر
- **Audit Trail** - ثبت تمام تغییرات
- **Version Control** - Rollback به نسخه‌های قبلی
- **Tenant Isolation** - برای Multi-tenant systems
- **Historical Accuracy** - دقت در بازتولید

#### ۳. Multi-tenant Support
- **Tenant Context** - ایزوله‌سازی داده‌های Tenant
- **Row-level Security** - سطح DB
- **Tenant Branding** - Theme مختص هر Tenant
- **Resource Quotas** - محدودیت منابع

#### ۴. Testing Strategy
- **Unit Tests** - برای Theme Engine
- **Integration Tests** - برای Database Operations
- **Snapshot Tests** - برای Historical Rendering
- **Performance Tests** - برای Caching

#### ۵. Performance Optimization
- **Lazy Loading** - برای MRT بزرگ
- **Query Optimization** - برای Historical Queries
- **Compression** - برای Theme Data
- **Connection Pooling** - برای Database

---

### 📋 Priority Roadmap برای پیاده‌سازی

| اولویت | کار | بازه زمانی |
|:---:|:---|:---|
| 🔴 **بالا** | Database Schema + Stored Procedures | ۱ هفته |
| 🔴 **بالا** | Theme Manager + Caching | ۲ هفته |
| 🔴 **بالا** | Neutral MRT Templates | ۲ هفته |
| 🟠 **متوسط** | Audit Trail Implementation | ۱ هفته |
| 🟠 **متوسط** | Unit Tests | ۲ هفته |
| 🟠 **متوسط** | Multi-tenant Support | ۲ هفته |
| 🟡 **کم** | Performance Tuning | ۱ هفته |
| 🟡 **کم** | Documentation | ۱ هفته |

---

### 💡 اصول طراحی Hybrid

| اصل | توضیح |
|:---|:---|
| **Single Source of Truth** | فقط یک جایی برای هر تصمیم |
| **Separation of Concerns** | هر لایه مسئولیت خاص |
| **Versioning Everything** | تمام تغییرات قابل ردیابی |
| **Audit & Compliance** | تمام عملیات ثبت‌شده |
| **Performance First** | Caching و Optimization |
| **Testability** | تمام کدها قابل تست |

---

<div align="center">

### اگر پروژه شما:

---

## ۸. نتیجه نهایی

<div align="center">

| معماری | مناسب برای |
|:---|:---|
| 🎨 Pure MRT | گزارش‌های کلاسیک، تیم‌های BI، طراحی سریع |
| 💻 Pure Code | سیستم‌های شدیداً داینامیک، معماری‌های خاص |
| ⚡ Hybrid | 🏆 تقریباً تمام Enterprise Appهای جدی |

### 📝 جمله نهایی تحقیق

> «در پروژه‌های مدرن سازمانی، فایل MRT نباید مرکز معماری باشد؛ بلکه باید به یک Skeleton قابل تزریق توسط موتور مرکزی گزارش‌سازی تبدیل شود.»

</div>

---

## ۹. پیوست: نمونه کدهای مرجع و عملی

> 📂 **تمام نمونه‌های کامل در پوشه [`examples/`](./examples) موجود هستند.**

### ۹.۱. نمونه کلاس ReportThemeManager (بهبود‌یافته)

**📄 فایل کامل:** [`examples/csharp/ReportThemeManager.cs`](./examples/csharp/ReportThemeManager.cs)

**ویژگی‌های کلیدی:**
- ✅ **Caching Strategy** - بهبود Performance
- ✅ **Async/Await** - عملیات ناهم‌زمان
- ✅ **Error Handling** - مدیریت استثناها جامع
- ✅ **Logging** - پیگیری عملیات

**نمونه استفاده:**
```csharp
var themeManager = new ReportThemeManager(dbContext, cache, logger);

// دریافت تم کاربر
var theme = await themeManager.GetEffectiveThemeAsync(
    userId: 123,
    historicalDate: new DateTime(2025, 1, 15)
);

// پاک کردن Cache برای Refresh
themeManager.InvalidateCache(userId: 123);
```

### ۹.۲. نمونه MRT خنثی (Neutral Template)

**📄 فایل کامل:** [`examples/xml/neutral_invoice.mrt`](./examples/xml/neutral_invoice.mrt)

**ویژگی‌های کلیدی:**
- ✅ فقط Layout بدون Styling
- ✅ Placeholder‌ها برای Runtime Injection
- ✅ پشتیبانی RTL
- ✅ Data Binding آماده

**نکته مهم:**
```xml
<!-- Template فقط Layout را تعریف می‌کند -->
<!-- تمام رنگ‌ها، فونت‌ها و Branding در Runtime اعمال می‌شود -->
<TextObject Name="CompanyNamePlaceholder">
  <Text>{{COMPANY_NAME}}</Text>
</TextObject>
```

### ۹.۳. طراحی پایگاه داده

**📄 فایل کامل:** [`examples/sql/ThemeDatabase.sql`](./examples/sql/ThemeDatabase.sql)

**جداول اصلی:**
- `ThemeVersions` - نسخه‌های تم
- `UserThemeOverrides` - Override‌های کاربر
- `ThemeAuditLog` - ثبت تغییرات
- `TenantThemes` - تم‌های Multi-tenant
- `ReportTemplateBindings` - ربط MRT و Themes

**Stored Procedures:**
```sql
-- دریافت تم موثر
EXEC sp_GetEffectiveTheme @UserId = 123, @HistoricalDate = '2025-01-15';

-- ایجاد نسخه جدید
EXEC sp_CreateThemeVersion 
    @VersionName = 'Blue-v2.1',
    @ThemeData = N'{...}',
    @CreatedBy = 'admin';
```

### ۹.۴. تم JSON جامع

**📄 فایل کامل:** [`examples/json/corporate-blue-v2.json`](./examples/json/corporate-blue-v2.json)

**بخش‌های اصلی:**
- 🎨 **Colors** - تمام رنگ‌های Theme
- 🔤 **Fonts** - Family، Size، Weight
- 🏢 **Branding** - لوگو و اطلاعات شرکت
- 📏 **Spacing** - Padding، Margin
- 📊 **Tables** - استایل جداول
- 📄 **Headers/Footers** - استایل صفحات
- 🌐 **RTL & Localization** - پشتیبانی راست‌به‌چپ

**نمونه ساختار:**
```json
{
  "themeName": "Corporate-Blue-v2.0",
  "colors": {
    "primary": "#007ACC",
    "text": { "primary": "#212121" }
  },
  "fonts": {
    "body": { "family": "Segoe UI", "size": 11 }
  }
}
```

### ۹.۵. چک‌لیست تصمیم‌گیری سریع

| سوال | اگر پاسخ "بله" است |
|:---|:---|
| 👥 آیا یک طراح گزارش تمام‌وقت دارید؟ | 🎨 روش MRT را جدی بگیرید |
| 👤 آیا کاربر نهایی باید گزارش بسازد؟ | 🎨 روش MRT الزامی است |
| 🔄 آیا ساختار گزارش در زمان اجرا کاملاً تغییر می‌کند؟ | ⚡ Hybrid یا 💻 Code-first |
| ⏳ آیا نیاز به بازتولید گزارش با ظاهر گذشته دارید؟ | 💻 Code-first یا ⚡ Hybrid |
| 🏢 آیا سیستم چندمشترکه (Multi-tenant) است؟ | ⚡ Hybrid |
| 👨‍💻 آیا تیم شما فقط برنامه‌نویس است؟ | ⚡ Hybrid با MRTهای خنثی |
| 🤖 آیا می‌خواهید از هوش مصنوعی برای طراحی سریع استفاده کنید؟ | 🧠 Stimul AI + 🎨 MRT |

---

## 📚 راهنمای Quick Start

1. **مطالعه:** [`examples/README.md`](./examples/README.md)
2. **راه‌اندازی DB:** `examples/sql/ThemeDatabase.sql`
3. **استفاده از کد:** `examples/csharp/ReportThemeManager.cs`
4. **طراحی Template:** `examples/xml/neutral_invoice.mrt`
5. **پیکربندی Theme:** `examples/json/corporate-blue-v2.json`

---

<div align="center">

⏻ **پایان سند** ⏻

تهیه شده با ❤️ برای تیم‌های فنی و معماران نرم‌افزار

**نسخه ۲.۱ | راهبری معماری گزارش‌سازی Stimulsoft**

</div>

</div>
