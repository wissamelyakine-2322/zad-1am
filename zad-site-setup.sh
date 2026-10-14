#!/bin/bash
# يُشغَّل من داخل ~/zad-1am : يجعل كل تحديث يبني نسخة أندرويد ونسخة ويندوز وينشرهما في صفحة الهبوط تلقائياً
set -e
[ -f config.xml ] && [ -d www ] || { echo "شغّلي هذا الأمر من داخل ~/zad-1am"; exit 1; }
mkdir -p site desktop/build .github/workflows

cat > site/build_site.py <<'ZADEOF'
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
    free_badge = "مجاني"
    free_note = ""
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
@keyframes blink{{0%,100%{{opacity:1;transform:scale(1)}}50%{{opacity:.25;transform:scale(1.12)}}}}
.badge{{animation:blink 1.1s ease-in-out infinite}}
@media (prefers-reduced-motion:reduce){{.badge{{animation:none}}}}
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
{f'<p style="font-size:15px">{e(free_note)}</p>' if free_note else ''}
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
ZADEOF

cat > site/site.config.json <<'ZADEOF'
{
  "freeForever": false,
  "repo": "wissamelyakine-2322/zad-1am",
  "siteUrl": "https://wissamelyakine-2322.github.io/zad-1am"
}
ZADEOF

cat > desktop/package.json <<'ZADEOF'
{
  "name": "zad-dz",
  "version": "1.0.0",
  "description": "Zad dz",
  "author": "Zad dz",
  "main": "main.js",
  "scripts": { "start": "electron ." },
  "devDependencies": { "electron": "31.7.7", "electron-builder": "24.13.3" },
  "build": {
    "appId": "com.zad.am1",
    "productName": "Zad dz",
    "directories": { "output": "dist" },
    "files": ["main.js", "app/**/*"],
    "icon": "build/icon.png",
    "win": { "target": ["portable", "nsis"] },
    "portable": { "artifactName": "ZadDz-Portable.exe" },
    "nsis": { "oneClick": false, "allowToChangeInstallationDirectory": true, "artifactName": "ZadDz-Setup.exe" }
  }
}
ZADEOF

cat > desktop/main.js <<'ZADEOF'
const { app, BrowserWindow, shell, Menu } = require('electron');
const path = require('path');
function createWindow() {
  const win = new BrowserWindow({ width: 1100, height: 800, minWidth: 420, minHeight: 600, title: 'Zad dz',
    icon: path.join(__dirname, 'build', 'icon.png'), webPreferences: { contextIsolation: true, nodeIntegration: false } });
  Menu.setApplicationMenu(null);
  win.loadFile(path.join(__dirname, 'app', 'index.html'));
  win.webContents.setWindowOpenHandler(({ url }) => { if (/^https?:\/\//i.test(url)) shell.openExternal(url); return { action: 'deny' }; });
  win.webContents.on('will-navigate', (e, url) => { if (/^https?:\/\//i.test(url)) { e.preventDefault(); shell.openExternal(url); } });
}
app.whenReady().then(createWindow);
app.on('window-all-closed', () => app.quit());
ZADEOF

# سير عمل واحد بدل ثلاثة: بناء أندرويد + ويندوز، ثم نشر الإصدار، ثم تحديث الصفحة
rm -f .github/workflows/build.yml .github/workflows/windows.yml .github/workflows/pages.yml
cat > .github/workflows/release.yml <<'ZADEOF'
name: Build and Release
on:
  push:
    branches: [main]
  workflow_dispatch:
permissions:
  contents: write
  pages: write
  id-token: write
concurrency:
  group: release
  cancel-in-progress: true
jobs:
  android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 18 }
      - uses: actions/setup-java@v4
        with: { distribution: temurin, java-version: 17 }
      - run: npm install -g cordova
      - run: cordova platform add android
      - run: cordova build android
      - run: cp platforms/android/app/build/outputs/apk/debug/app-debug.apk Zad-dz.apk
      - uses: actions/upload-artifact@v4
        with:
          name: zad-apk
          path: Zad-dz.apk

  windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 18 }
      - name: Prepare app files
        shell: pwsh
        run: |
          New-Item -ItemType Directory -Force desktop/app, desktop/build | Out-Null
          Copy-Item -Recurse -Force www/* desktop/app/
          Copy-Item -Force res/icon.png desktop/build/icon.png
      - name: Install
        working-directory: desktop
        run: npm install
      - name: Build exe
        working-directory: desktop
        env:
          CSC_IDENTITY_AUTO_DISCOVERY: "false"
        run: npx electron-builder --win --publish never
      - uses: actions/upload-artifact@v4
        with:
          name: zad-windows
          path: |
            desktop/dist/ZadDz-Portable.exe
            desktop/dist/ZadDz-Setup.exe

  publish:
    needs: [android, windows]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with:
          pattern: zad-*
          path: out
          merge-multiple: true
      - name: Move the latest tag to this commit
        run: |
          git config user.name "github-actions"
          git config user.email "actions@github.com"
          git tag -f latest
          git push -f origin latest
      - uses: softprops/action-gh-release@v2
        with:
          tag_name: latest
          name: Zad dz - بناء رقم ${{ github.run_number }}
          make_latest: true
          files: |
            out/Zad-dz.apk
            out/ZadDz-Portable.exe
            out/ZadDz-Setup.exe

  pages:
    needs: publish
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: "3.x" }
      - name: Read release info
        env:
          GH_TOKEN: ${{ github.token }}
        run: |
          gh release view latest --repo "${{ github.repository }}" --json assets > site/release.json
          jq --arg n "${{ github.run_number }}" '. + {buildNumber: ($n|tonumber)}' site/release.json > site/release.tmp && mv site/release.tmp site/release.json
      - run: python3 site/build_site.py
      - uses: actions/configure-pages@v5
      - uses: actions/upload-pages-artifact@v3
        with: { path: site/dist }
      - id: deployment
        uses: actions/deploy-pages@v4
ZADEOF

touch .gitignore
for p in site/dist site/release.json desktop/node_modules desktop/dist desktop/app; do grep -qxF "$p" .gitignore || echo "$p" >> .gitignore; done
echo "تم. سير العمل: .github/workflows/release.yml"
[ -f www/img/logo.png ] && echo "الشعار موجود" || echo "تنبيه: www/img/logo.png غير موجود"
[ -f res/icon.png ] && echo "الأيقونة موجودة" || echo "تنبيه: res/icon.png غير موجودة"
