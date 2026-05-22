# سند راهبرد معماری گزارش‌سازی در Stimulsoft
## تحلیل نهایی معماری، نقش هوش مصنوعی و چارچوب تصمیم‌گیری سازمانی

> نسخه: ۲.۱ — ویرایش نهایی معماری Enterprise
>
> تاریخ: ۲ خرداد ۱۴۰۵
>
> وضعیت: نهایی – نسخه تصمیم‌سازی معماری
>
> مخاطب: معمار نرم‌افزار، تیم بک‌اند، مدیر فنی، تیم BI و توسعه‌دهندگان گزارش

---

# خلاصه مدیریتی (Executive Snapshot)

## اگر فقط ۳۰ ثانیه وقت دارید:

| سؤال | پاسخ نهایی |
|---|---|
| بهترین معماری برای اکثر پروژه‌های Enterprise چیست؟ | Hybrid Architecture |
| بهترین AI برای طراحی MRT چیست؟ | Stimul AI |
| بهترین AI برای معماری و کدنویسی چیست؟ | ChatGPT / Claude |
| آیا Pure MRT برای پروژه‌های بزرگ کافی است؟ | معمولاً خیر |
| آیا Pure Code انعطاف‌پذیرترین روش است؟ | بله |
| آیا Pure Code هزینه نگهداری بالایی دارد؟ | بله |
| نتیجه نهایی؟ | MRT برای Layout + Code برای Runtime |

---

# نتیجه نهایی تحقیق

## معماری پیشنهادی برای سیستم‌های مدرن سازمانی:

# ✅ Hybrid Architecture

یعنی:

- استفاده از MRT فقط به‌عنوان Skeleton/Layout
- مدیریت تمام Theme و Styling توسط Runtime Engine
- تزریق استایل‌ها در زمان اجرا
- مدیریت مرکزی Theme و Historical Version

---

# چرا این موضوع مهم است؟

در سیستم‌های سازمانی، گزارش فقط «خروجی چاپ» نیست.

گزارش می‌تواند:

- سند مالی
- سند حقوقی
- سند Audit
- Snapshot تاریخی
- هویت بصری سازمان
- یا بخشی از Workflow رسمی سیستم

باشد.

بنابراین معماری گزارش‌سازی باید بتواند:

| نیاز | توضیح |
|---|---|
| Dynamic Rendering | ساختار گزارش در Runtime تغییر کند |
| Historical Reproduction | ظاهر گزارش در گذشته بازسازی شود |
| Multi-tenant Branding | هر مشتری/شعبه Theme جدا داشته باشد |
| Maintainability | نگهداری بلندمدت ممکن باشد |
| Versionability | تغییرات قابل رهگیری باشند |
| AI-assisted Development | از AI استفاده شود |

---

# سه معماری اصلی گزارش‌سازی

---

# ۱) MRT-first Architecture
## (Designer-first)

در این مدل:

- گزارش داخل Designer ساخته می‌شود
- خروجی فایل MRT است
- تمرکز روی طراحی بصری است

---

## مزایا

### ✅ طراحی سریع
- Drag & Drop
- مناسب تیم BI
- مناسب Designer

### ✅ سازگاری عالی با Stimul AI

### ✅ مناسب کاربران غیر برنامه‌نویس

### ✅ توسعه سریع فرم‌ها و گزارش‌های کلاسیک

---

## معایب

### ❌ مشکل شدید Git و Merge
فایل MRT در اصل XML است.

بنابراین:
- Diff ناخوانا
- Merge Conflict شدید
- Review سخت

---

### ❌ نگهداری دشوار در مقیاس بالا
مثلاً تغییر فونت کل سازمان:
- ممکن است نیازمند ویرایش صدها MRT باشد.

---

### ❌ ضعف در Dynamic Layout
سناریوهای زیر سخت می‌شوند:

- ستون‌های Runtime
- Layout وابسته به داده
- Dynamic Structure

---

### ❌ Historical Rendering ضعیف
بازسازی ظاهر گذشته دشوار است.

---

## مناسب برای چه پروژه‌هایی؟

| پروژه | وضعیت |
|---|---|
| BI-heavy | عالی |
| سیستم کوچک | عالی |
| گزارش‌های استاتیک | عالی |
| Enterprise پیچیده | متوسط |
| سیستم Dynamic | ضعیف |

---

# ۲) Code-first Architecture

در این مدل:

- تمام اجزا با C# ساخته می‌شوند
- Runtime کنترل کامل دارد
- گزارش عملاً Programmatic است

---

## مزایا

### ✅ انعطاف‌پذیری بسیار بالا

### ✅ Git Friendly
کد:
- reviewable
- diffable
- testable

است.

---

### ✅ Testability واقعی
امکان:
- Unit Test
- Snapshot Test
- Regression Test

وجود دارد.

---

### ✅ مناسب Multi-tenant و White-label

---

### ✅ Historical Reproduction واقعی

---

## معایب

### ❌ پیچیدگی شدید Layout Engine

مشکلات:
- Pagination
- Overflow
- Nested Bands
- RTL
- Spacing

باید دستی مدیریت شوند.

---

### ❌ افزایش Technical Debt

بعد از چند سال:
- Alignment Bug
- Style Drift
- Duplicate Rendering Logic

رخ می‌دهد.

---

### ❌ نیاز به تخصص بالا

نیازمند:
- تسلط C#
- شناخت عمیق Stimulsoft
- معماری Theme
- طراحی Component System

است.

---

### ❌ عدم استفاده از Stimul AI

---

## مناسب برای چه پروژه‌هایی؟

| پروژه | وضعیت |
|---|---|
| Dynamic Runtime Reports | عالی |
| White-label SaaS | عالی |
| Enterprise پیچیده | عالی |
| تیم BI غیر فنی | ضعیف |

---

# ۳) Hybrid Architecture
## (پیشنهاد نهایی)

در این مدل:

- MRT فقط Skeleton است
- Runtime تمام Theme و Style را اعمال می‌کند
- Business Logic در Code قرار دارد

---

# معماری پیشنهادی

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
