#!/usr/bin/env python3
"""يولّد صفحة الهبوط تلقائياً من بيانات التطبيق (www/) عند كل رفع."""
import json, re, shutil, sys, html
from pathlib import Path
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parent.parent
WWW, OUT = ROOT / "www", ROOT / "site" / "dist"
CFG = json.loads((ROOT / "site" / "site.config.json").read_text(encoding="utf-8"))

def load_js(path, var):
    s = path.read_text(encoding="utf-8")
    return json.loads(s[s.index("=") + 1:].strip().rstrip(";"))

DB = load_js(WWW / "db.js", "DB")
LS = load_js(WWW / "lessons.js", "LESSONS_DB")
idx = (WWW / "index.html").read_text(encoding="utf-8")
m = re.search(r"TRIAL_END:\s*new Date\('(\d{4})-(\d{2})-(\d{2})", idx)
trial_end = datetime(int(m[1]), int(m[2]), int(m[3])) if m else None
MONTHS = ["يناير","فبراير","مارس","أفريل","ماي","جوان","جويلية","أوت","سبتمبر","أكتوبر","نوفمبر","ديسمبر"]
def ar_date(d): return f"{d.day} {MONTHS[d.month-1]} {d.year}"

# ---------- إحصاءات من البيانات ----------
n_lessons = n_ex = 0
subjects_with_content = set()
for lvl, subs in LS.items():
    for k, v in subs.items():
        n_lessons += len(v.get("lessons", [])); n_ex += len(v.get("exercises", []))
        if v.get("lessons"): subjects_with_content.add((lvl, k))
n_links = len(re.findall(r'"url"', json.dumps(DB)))

am_rows, as_rows = [], []
for k, lv in DB["levels"].items():
    has = k in LS
    am_rows.append((lv["name"], "دروس وتمارين وأستاذ وكويز + روابط" if has else "روابط الكتب والدروس والفروض"))
for k, lv in DB["secondary"].items():
    keys = set(LS.get(k, {}).keys())
    full = [s["name"] for s in lv["streams"] if any(x["key"] in keys for x in s["subjects"])]
    as_rows.append((lv["name"], ("دروس وتمارين وأستاذ وكويز: " + "، ".join(full) + " — وروابط لبقية الشعب") if full else "روابط الدروس والفروض لكل الشعب"))
# ---------- نص المجانية (صادق ومرتبط بإعداد التطبيق) ----------
free_forever = bool(CFG.get("freeForever"))
today = datetime.now(timezone.utc).replace(tzinfo=None)
if free_forever:
    free_badge = "مجاني بالكامل"
    free_note = "بدون اشتراك وبدون مفتاح تفعيل."
    faq_free = "نعم، التطبيق مجاني بالكامل بدون اشتراك."
elif trial_end:
    free_badge = f"مجاني — تجربة كاملة حتى {ar_date(trial_end)}"
    free_note = ("بعد انتهاء الفترة التجريبية يلزم مفتاح تفعيل." if today <= trial_end else "الفترة التجريبية انتهت، ويلزم مفتاح تفعيل.")
    faq_free = f"التطبيق مجاني خلال الفترة التجريبية حتى {ar_date(trial_end)}، وبعدها يلزم مفتاح تفعيل."
else:
    free_badge = "مجاني"; free_note = ""; faq_free = "التطبيق مجاني."

REPO, SITE = CFG["repo"], CFG["siteUrl"].rstrip("/")
rel_info = ""
rj = ROOT / "site" / "release.json"
if rj.exists():
    try:
        R = json.loads(rj.read_text(encoding="utf-8"))
        parts = []
        for a in R.get("assets", []):
            nm = {"Zad-dz.apk": "أندرويد", "ZadDz-Setup.exe": "ويندوز (تثبيت)", "ZadDz-Portable.exe": "ويندوز (بدون تثبيت)"}.get(a["name"])
            if nm:
                d = datetime.strptime(a["updatedAt"][:10], "%Y-%m-%d")
                parts.append(f"{nm}: {a['size']/1048576:.0f} MB — {ar_date(d)}")
        if parts: rel_info = "آخر بناء — " + " · ".join(parts) + (f" · رقم البناء {R['buildNumber']}" if R.get("buildNumber") else "")
    except Exception as ex:
        print("release.json ignored:", ex)
REL = f"https://github.com/{REPO}/releases/download/latest"
apk, exe_p, exe_s = f"{REL}/Zad-dz.apk", f"{REL}/ZadDz-Portable.exe", f"{REL}/ZadDz-Setup.exe"
version, season = DB.get("version", ""), DB.get("season", "")
updated = ar_date(today)
FREE_WORD = "مجانية" if free_forever else "بتجربة مجانية كاملة"
TITLE = f"Zad dz — دراسة {FREE_WORD} للتعليم المتوسط والثانوي في الجزائر | دروس وتمارين وأستاذ"
DESC = ("تطبيق Zad dz التعليمي: دروس وتمارين وكويز وأستاذ محلي يعمل بدون إنترنت لكل مستويات المتوسط والثانوي في الجزائر، "
        "مع روابط الكتب والفروض والاختبارات. حمّليه لأندرويد أو ويندوز أو افتحيه من المتصفح.")
e = html.escape
rows = lambda r: "".join(f"<tr><th>{e(a)}</th><td>{e(b)}</td></tr>" for a, b in r)

faq = [
 ("هل التطبيق مجاني؟", faq_free),
 ("هل يعمل بدون إنترنت؟", "نعم، الدروس والتمارين والكويز والأستاذ المحلي تعمل بدون إنترنت. روابط الكتب والفروض تحتاج إنترنت."),
 ("ما المستويات التي يغطيها؟", "السنوات الأربع للتعليم المتوسط والسنوات الثلاث للتعليم الثانوي بكل شعبها، مع محتوى محلي كامل لبعضها وروابط للبقية."),
 ("على أي أجهزة يعمل؟", "هواتف أندرويد، وحواسيب ويندوز، وأي متصفح حديث."),
 ("هل يتحدث المحتوى تلقائياً؟", "نعم، تتحدث هذه الصفحة والنسخة المتصفحية مع كل تحديث للتطبيق."),
]
ld = [{
  "@context": "https://schema.org", "@type": "SoftwareApplication", "name": "Zad dz",
  "alternateName": "زاد دز", "applicationCategory": "EducationalApplication",
  "operatingSystem": "Android, Windows, Web", "inLanguage": "ar", "url": SITE + "/",
  "description": DESC, "softwareVersion": version, "dateModified": today.strftime("%Y-%m-%d"),
  "image": SITE + "/logo.png",
  **({"offers": {"@type": "Offer", "price": "0", "priceCurrency": "DZD"}} if free_forever else {}),
 }, {
  "@context": "https://schema.org", "@type": "FAQPage",
  "mainEntity": [{"@type": "Question", "name": q, "acceptedAnswer": {"@type": "Answer", "text": a}} for q, a in faq]}]

PAGE = f"""<!doctype html>
<html lang="ar" dir="rtl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{e(TITLE)}</title>
<meta name="description" content="{e(DESC)}">
<meta name="keywords" content="دراسة مجانية, تعليم متوسط, تعليم ثانوي, الجزائر, دروس, تمارين, فروض, اختبارات, بكالوريا, BEM, تطبيق تعليمي, Zad dz">
<link rel="canonical" href="{SITE}/">
<meta name="robots" content="index,follow,max-image-preview:large">
<meta property="og:type" content="website"><meta property="og:locale" content="ar_DZ">
<meta property="og:title" content="{e(TITLE)}"><meta property="og:description" content="{e(DESC)}">
<meta property="og:url" content="{SITE}/"><meta property="og:image" content="{SITE}/logo.png">
<meta name="twitter:card" content="summary">
<meta name="theme-color" content="#0b2a7a">
<link rel="icon" href="logo.png">
<script type="application/ld+json">{json.dumps(ld, ensure_ascii=False)}</script>
<style>
:root{{--blue:#0b2a7a;--blue2:#1747c4;--gold:#e8a91a;--ink:#14213d;--bg:#f6f8fd}}
*{{box-sizing:border-box}}body{{margin:0;font-family:"Segoe UI",Tahoma,"Noto Naskh Arabic",Arial,sans-serif;color:var(--ink);background:var(--bg);line-height:1.9}}
.wrap{{max-width:980px;margin:auto;padding:0 18px}}
header.hero{{background:linear-gradient(160deg,var(--blue),var(--blue2));color:#fff;text-align:center;padding:36px 0 54px}}
.hero img{{width:150px;height:150px;filter:drop-shadow(0 8px 18px rgba(0,0,0,.35))}}
h1{{font-size:clamp(24px,5vw,38px);margin:10px 0 6px;line-height:1.5}}
.hero p{{max-width:640px;margin:6px auto;font-size:18px;opacity:.95}}
.badge{{display:inline-block;background:var(--gold);color:#2b1d00;font-weight:bold;border-radius:30px;padding:6px 18px;margin:10px 0}}
.btns{{display:flex;flex-wrap:wrap;gap:12px;justify-content:center;margin-top:20px}}
.btn{{background:#fff;color:var(--blue);text-decoration:none;font-weight:bold;border-radius:14px;padding:13px 22px;font-size:17px;box-shadow:0 4px 14px rgba(0,0,0,.25)}}
.btn.alt{{background:var(--gold);color:#2b1d00}}
section{{padding:34px 0}}h2{{font-size:26px;margin:0 0 14px;border-right:6px solid var(--gold);padding-right:12px}}
.grid{{display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:14px}}
.card{{background:#fff;border-radius:16px;padding:18px;box-shadow:0 2px 10px rgba(20,33,61,.09)}}
.card b{{display:block;font-size:19px;color:var(--blue)}}
.stats{{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:12px;text-align:center}}
.stat{{background:#fff;border-radius:16px;padding:16px}}.stat strong{{display:block;font-size:30px;color:var(--blue2)}}
table{{width:100%;border-collapse:collapse;background:#fff;border-radius:14px;overflow:hidden;margin-bottom:16px}}
th,td{{padding:11px 14px;text-align:right;border-bottom:1px solid #e6ebf5;vertical-align:top}}th{{width:34%;background:#eef2fb;color:var(--blue)}}
details{{background:#fff;border-radius:12px;padding:12px 16px;margin-bottom:10px}}summary{{cursor:pointer;font-weight:bold}}
footer{{background:var(--blue);color:#cfd9f5;text-align:center;padding:22px 0;font-size:14px}}
.note{{font-size:14px;color:#566}}
.build{{font-size:13px;opacity:.9;margin-top:16px}}
</style>
</head>
<body>
<header class="hero"><div class="wrap">
<img src="logo.png" alt="شعار Zad dz — تطبيق تعليمي للتعليم المتوسط والثانوي" width="150" height="150">
<h1>Zad dz — دراسة {FREE_WORD} لكل مستويات المتوسط والثانوي</h1>
<p>دروس وتمارين وكويز وأستاذ يشرح لك بدون إنترنت، مع روابط الكتب والفروض والاختبارات والبكالوريا.</p>
<div class="badge">{e(free_badge)}</div>
<p style="font-size:15px">{e(free_note)}</p>
<div class="btns">
<a class="btn alt" href="{apk}">⬇ تحميل لأندرويد (APK)</a>
<a class="btn" href="{exe_s}">⬇ تثبيت على ويندوز</a>
<a class="btn" href="{exe_p}">ويندوز بدون تثبيت</a>
<a class="btn" href="app/">🌐 افتحي من المتصفح</a>
</div>
{f'<p class="build">{e(rel_info)}</p>' if rel_info else ''}
</div></header>
<main class="wrap">
<section aria-labelledby="stats"><h2 id="stats">ماذا يحتوي التطبيق الآن؟</h2>
<div class="stats">
<div class="stat"><strong>{n_lessons}</strong>درساً</div>
<div class="stat"><strong>{n_ex}</strong>مجموعة تمارين</div>
<div class="stat"><strong>{n_links}</strong>رابطاً للكتب والفروض</div>
<div class="stat"><strong>{len(DB['levels'])+len(DB['secondary'])}</strong>مستويات دراسية</div>
</div>
<p class="note">الأرقام تُحسب تلقائياً من محتوى التطبيق. آخر تحديث: {updated} — الإصدار {e(version)} — موسم {e(season)}.</p></section>
<section aria-labelledby="feat"><h2 id="feat">مميزات التطبيق</h2>
<div class="grid">
<div class="card"><b>📖 دروس مشروحة</b>ملخص وشرح موسّع وأمثلة محلولة لكل درس.</div>
<div class="card"><b>✏️ تمارين بالتصحيح</b>تمارين محلولة تتدرّبين بها خطوة بخطوة.</div>
<div class="card"><b>💬 أستاذ بدون إنترنت</b>اكتبي سؤالك فيجد لك الدرس، وبضغطة ثانية يشرح أكثر.</div>
<div class="card"><b>📝 كويز</b>اختبري نفسك بأسئلة جديدة في كل مرة.</div>
<div class="card"><b>🔗 روابط جاهزة</b>كتب مدرسية وفروض واختبارات لكل مادة.</div>
<div class="card"><b>🔄 تحديث تلقائي</b>كل ما يُضاف للتطبيق يظهر هنا في النسخة المتصفحية.</div>
</div></section>
<section aria-labelledby="lv"><h2 id="lv">المستويات المتوفرة</h2>
<h3>التعليم المتوسط</h3><table>{rows(am_rows)}</table>
<h3>التعليم الثانوي</h3><table>{rows(as_rows)}</table></section>
<section aria-labelledby="faq"><h2 id="faq">أسئلة شائعة</h2>
{''.join(f'<details><summary>{e(q)}</summary><p>{e(a)}</p></details>' for q, a in faq)}</section>
</main>
<footer><div class="wrap">Zad dz © {today.year} — تطبيق تعليمي جزائري. هذا المشروع غير تابع لوزارة التربية الوطنية.</div></footer>
</body></html>
"""

if OUT.exists(): shutil.rmtree(OUT)
OUT.mkdir(parents=True)
(OUT / "index.html").write_text(PAGE, encoding="utf-8")
shutil.copy(WWW / "img" / "logo.png", OUT / "logo.png")
shutil.copytree(WWW, OUT / "app")                       # نسخة المتصفح من التطبيق نفسه
(OUT / "robots.txt").write_text(f"User-agent: *\nAllow: /\nSitemap: {SITE}/sitemap.xml\n")
(OUT / "sitemap.xml").write_text(
 f'<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
 f'<url><loc>{SITE}/</loc><lastmod>{today.strftime("%Y-%m-%d")}</lastmod><changefreq>weekly</changefreq><priority>1.0</priority></url>\n'
 f'<url><loc>{SITE}/app/</loc><lastmod>{today.strftime("%Y-%m-%d")}</lastmod></url>\n</urlset>\n')
print("OK:", n_lessons, "lessons,", n_ex, "ex,", n_links, "links;", "free_forever" if free_forever else "trial")
