#!/usr/bin/env python3
"""مولّد مفاتيح التفعيل — للبائع فقط (لا ترفعيه مع السر إلى مكان عام).

أمثلة:
  python3 tools/keygen.py --device 1234-5678-9012 --scope M1
  python3 tools/keygen.py --device 123456789012 --scope S2-TM --scope S3-TM
  python3 tools/keygen.py --device 123456789012 --scope ALL      # تفعيل عام لكل السنوات والشعب
  python3 tools/keygen.py --list

السر: من المتغير ZAD_SECRET أو من ملف tools/.secret أو من CONFIG.LICENSE_SECRET في www/index.html.
الرقم التسلسلي الافتراضي هو الشهر الحالي (YYYYMM)، ويجب على الزبون تفعيل المفتاح خلال 6 أشهر من إصداره.
كل مفتاح: جهاز واحد + رمز واحد، وصالح 365 يوماً من لحظة التفعيل.
"""
import argparse, base64, datetime, hashlib, hmac, os, re, sys

STREAMS = {"S1": ["ST", "LET"], "S2": ["SE", "MATH", "TM", "GE", "LP", "LE"], "S3": ["SE", "MATH", "TM", "GE", "LP", "LE"]}
SCOPES = ["M1", "M2", "M3", "M4"] + [f"{lv}-{c}" for lv, arr in STREAMS.items() for c in arr] + ["ALL"]
LABELS = {
    "M1": "الأولى متوسط", "M2": "الثانية متوسط", "M3": "الثالثة متوسط", "M4": "الرابعة متوسط",
    "ST": "جذع مشترك علوم وتكنولوجيا", "LET": "جذع مشترك آداب", "SE": "علوم تجريبية", "MATH": "رياضيات",
    "TM": "تقني رياضي", "GE": "تسيير واقتصاد", "LP": "آداب وفلسفة", "LE": "لغات أجنبية",
}
B32 = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def get_secret():
    if os.environ.get("ZAD_SECRET"):
        return os.environ["ZAD_SECRET"]
    p = os.path.join(ROOT, "tools", ".secret")
    if os.path.exists(p):
        return open(p, encoding="utf-8").read().strip()
    html = open(os.path.join(ROOT, "www", "index.html"), encoding="utf-8").read()
    m = re.search(r"LICENSE_SECRET:\s*'([^']+)'", html)
    if not m:
        sys.exit("لم أجد السر. ضعيه في ZAD_SECRET أو tools/.secret")
    return m.group(1)


def to_b32(data, n):
    bits = val = 0
    out = ""
    for b in data:
        val = ((val << 8) | b) & 0xFFFF
        bits += 8
        while bits >= 5 and len(out) < n:
            out += B32[(val >> (bits - 5)) & 31]
            bits -= 5
        val &= 0xFF
    return out


def make_key(secret, device, scope, serial):
    mac = hmac.new(secret.encode(), f"LIC|{device}|{scope}|{serial}".encode(), hashlib.sha256).digest()
    k = to_b32(mac, 15)
    return "-".join(k[i:i + 5] for i in range(0, 15, 5))


def scope_label(s):
    if s == "ALL":
        return "تفعيل عام — كل السنوات والشعب"
    if s.startswith("M"):
        return LABELS[s]
    lv, c = s.split("-")
    return {"S1": "أولى ثانوي", "S2": "ثانية ثانوي", "S3": "ثالثة ثانوي"}[lv] + " — " + LABELS[c]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--device", help="رمز الجهاز (12 رقماً، مع أو بدون شرطات)")
    ap.add_argument("--scope", action="append", help="M1..M4 أو S1/S2/S3-ST|LET|SE|MATH|TM|GE|LP|LE أو ALL (تفعيل عام)")
    ap.add_argument("--serial", type=int, help="الرقم التسلسلي YYYYMM (الافتراضي الشهر الحالي)")
    ap.add_argument("--list", action="store_true", help="عرض الرموز المتاحة")
    a = ap.parse_args()
    if a.list:
        for s in SCOPES:
            print(f"{s:8} {scope_label(s)}")
        return
    if not a.device or not a.scope:
        ap.error("--device و --scope مطلوبان")
    dev = re.sub(r"\D", "", a.device)
    if len(dev) != 12:
        sys.exit("رمز الجهاز يجب أن يكون 12 رقماً")
    serial = a.serial or int(datetime.date.today().strftime("%Y%m"))
    secret = get_secret()
    for s in a.scope:
        s = s.upper()
        if s not in SCOPES:
            sys.exit(f"رمز غير معروف: {s} (استعملي --list)")
        print(f"{s:8} {scope_label(s):34} {make_key(secret, dev, s, serial)}   (serial {serial})")


if __name__ == "__main__":
    main()
