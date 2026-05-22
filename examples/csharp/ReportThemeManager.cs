using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Stimulsoft.Reporting.Theme
{
    /// <summary>
    /// معرف‌های Theme Engine برای معماری هیبریدی
    /// </summary>
    public interface IReportThemeManager
    {
        Task<ReportTheme> GetEffectiveThemeAsync(
            int? userId = null,
            DateTime? historicalDate = null,
            CancellationToken cancellationToken = default);
    }

    /// <summary>
    /// پیاده‌سازی بهبود‌یافته ReportThemeManager با Caching و Error Handling
    /// </summary>
    public class ReportThemeManager : IReportThemeManager
    {
        private readonly IMemoryCache _cache;
        private readonly ApplicationDbContext _db;
        private readonly ILogger<ReportThemeManager> _logger;
        private const string BASE_THEME_PATH = "Themes/base_theme.json";
        private const string CACHE_KEY_PREFIX = "theme_";
        private const int CACHE_DURATION_HOURS = 1;

        public ReportThemeManager(
            ApplicationDbContext db,
            IMemoryCache cache,
            ILogger<ReportThemeManager> logger)
        {
            _db = db ?? throw new ArgumentNullException(nameof(db));
            _cache = cache ?? throw new ArgumentNullException(nameof(cache));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// دریافت تم موثر با در نظر گرفتن Overrides کاربر و تاریخچه
        /// </summary>
        public async Task<ReportTheme> GetEffectiveThemeAsync(
            int? userId = null,
            DateTime? historicalDate = null,
            CancellationToken cancellationToken = default)
        {
            try
            {
                // ۱. جستجو در Cache
                var cacheKey = GenerateCacheKey(userId, historicalDate);
                if (_cache.TryGetValue(cacheKey, out ReportTheme cachedTheme))
                {
                    _logger.LogDebug("Theme loaded from cache: {CacheKey}", cacheKey);
                    return cachedTheme;
                }

                // ۲. لود تم پایه از JSON
                var theme = await LoadBaseThemeAsync(cancellationToken);

                // ۳. اعمال Override‌های کاربر
                if (userId.HasValue)
                {
                    theme = await ApplyUserOverridesAsync(theme, userId.Value, cancellationToken);
                }

                // ۴. بازتولید تاریخی
                if (historicalDate.HasValue)
                {
                    theme = await ApplyHistoricalThemeAsync(theme, historicalDate.Value, cancellationToken);
                }

                // ۵. ذخیره در Cache
                var cacheOptions = new MemoryCacheEntryOptions()
                    .SetAbsoluteExpiration(TimeSpan.FromHours(CACHE_DURATION_HOURS));
                _cache.Set(cacheKey, theme, cacheOptions);

                _logger.LogInformation("Theme generated and cached: userId={UserId}, date={Date}", userId, historicalDate);
                return theme;
            }
            catch (FileNotFoundException ex)
            {
                _logger.LogError(ex, "Base theme file not found at {Path}", BASE_THEME_PATH);
                throw new InvalidOperationException($"Theme configuration not found at {BASE_THEME_PATH}", ex);
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Failed to deserialize theme JSON");
                throw new InvalidOperationException("Invalid theme configuration format", ex);
            }
            catch (OperationCanceledException)
            {
                _logger.LogWarning("Theme loading operation cancelled");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error loading theme for userId={UserId}, date={Date}",
                    userId, historicalDate);
                throw;
            }
        }

        /// <summary>
        /// لود تم پایه از فایل JSON
        /// </summary>
        private async Task<ReportTheme> LoadBaseThemeAsync(CancellationToken cancellationToken)
        {
            var json = await File.ReadAllTextAsync(BASE_THEME_PATH, cancellationToken);
            return JsonConvert.DeserializeObject<ReportTheme>(json)
                ?? throw new InvalidOperationException("Base theme deserialization returned null");
        }

        /// <summary>
        /// اعمال Override‌های مخصوص کاربر
        /// </summary>
        private async Task<ReportTheme> ApplyUserOverridesAsync(
            ReportTheme baseTheme,
            int userId,
            CancellationToken cancellationToken)
        {
            var userOverrides = await _db.UserThemeOverrides
                .FirstOrDefaultAsync(u => u.UserId == userId, cancellationToken);

            if (userOverrides != null)
            {
                var theme = (ReportTheme)baseTheme.Clone();
                theme.ApplyOverrides(userOverrides);
                _logger.LogDebug("Applied user overrides for userId={UserId}", userId);
                return theme;
            }

            return baseTheme;
        }

        /// <summary>
        /// اعمال تم تاریخی برای بازتولید دقیق
        /// </summary>
        private async Task<ReportTheme> ApplyHistoricalThemeAsync(
            ReportTheme baseTheme,
            DateTime historicalDate,
            CancellationToken cancellationToken)
        {
            var historicalTheme = await _db.ThemeVersions
                .Where(t => t.IsActive && t.ValidFrom <= historicalDate)
                .OrderByDescending(t => t.ValidFrom)
                .FirstOrDefaultAsync(cancellationToken);

            if (historicalTheme != null)
            {
                _logger.LogDebug("Using historical theme version {VersionName} for date {Date}",
                    historicalTheme.VersionName, historicalDate);
                return historicalTheme.ThemeData;
            }

            _logger.LogWarning("No historical theme found for date {Date}, using current theme", historicalDate);
            return baseTheme;
        }

        /// <summary>
        /// تولید کلید Cache یکتا
        /// </summary>
        private string GenerateCacheKey(int? userId, DateTime? historicalDate)
        {
            return $"{CACHE_KEY_PREFIX}{userId?.ToString() ?? "default"}_{historicalDate?.ToString("O") ?? "current"}";
        }

        /// <summary>
        /// پاک‌کردن Cache (برای refresh)
        /// </summary>
        public void InvalidateCache(int? userId = null, DateTime? historicalDate = null)
        {
            if (userId.HasValue && historicalDate.HasValue)
            {
                var cacheKey = GenerateCacheKey(userId, historicalDate);
                _cache.Remove(cacheKey);
                _logger.LogInformation("Cache invalidated for userId={UserId}", userId);
            }
        }
    }

    /// <summary>
    /// مدل داده‌ای ReportTheme
    /// </summary>
    public class ReportTheme : ICloneable
    {
        public string ThemeName { get; set; }
        public string Version { get; set; }
        public Dictionary<string, string> Colors { get; set; } = new();
        public Dictionary<string, FontInfo> Fonts { get; set; } = new();
        public BrandingInfo Branding { get; set; } = new();

        public void ApplyOverrides(UserThemeOverride overrides)
        {
            // پیاده‌سازی
        }

        public object Clone()
        {
            return MemberwiseClone();
        }
    }

    public class FontInfo
    {
        public string Family { get; set; }
        public int Size { get; set; }
        public bool Bold { get; set; }
        public bool Italic { get; set; }
    }

    public class BrandingInfo
    {
        public string LogoUrl { get; set; }
        public string CompanyName { get; set; }
        public string PrimaryColor { get; set; }
        public string SecondaryColor { get; set; }
    }

    public class UserThemeOverride
    {
        public int UserId { get; set; }
        public Dictionary<string, object> OverrideData { get; set; } = new();
    }

    public class ThemeVersion
    {
        public int Id { get; set; }
        public string VersionName { get; set; }
        public DateTime ValidFrom { get; set; }
        public DateTime? ValidTo { get; set; }
        public ReportTheme ThemeData { get; set; }
        public string ChangeDescription { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public bool IsActive { get; set; } = true;
    }
}
