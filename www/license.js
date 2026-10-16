/* ============================================================
   نظام التراخيص — Zad dz
   - مفتاح لكل سنة متوسط (M1..M4) ولكل شعبة ثانوي (S1-xx, S2-xx, S3-xx)
   - المفتاح مرتبط برمز جهاز واحد، وصالح 365 يوماً من لحظة التفعيل
   - المفتاح = HMAC-SHA256(سر، رمز الجهاز + الرمز + الرقم التسلسلي)
   يعتمد على CONFIG.LICENSE_SECRET (معرّف في index.html)
   ============================================================ */
const LIC = {
  DAYS: 365,
  SERIAL_BACK: 5,   // يُقبل مفتاح صُدر خلال الأشهر الستة الأخيرة (يجب تفعيله قبل ذلك)
  STREAMS: {
    S1: ['ST','LET'],
    S2: ['SE','MATH','TM','GE','LP','LE'],
    S3: ['SE','MATH','TM','GE','LP','LE']
  }
};
/* M1..M4: سنة متوسط • S1/S2/S3-xx: سنة + شعبة ثانوي • ALL: تفعيل عام لكل شيء */
const LIC_SCOPES = ['M1','M2','M3','M4']
  .concat(...Object.entries(LIC.STREAMS).map(([lv,arr]) => arr.map(c => lv+'-'+c)), ['ALL']);

/* ---------- SHA-256 + HMAC بدون مكتبات ---------- */
const _SHA = (() => {
  const K = [], H0 = []; let n = 2, c = 0;
  while(c < 64){
    let p = true; for(let d = 2; d*d <= n; d++) if(n % d === 0){ p = false; break; }
    if(p){
      if(c < 8) H0.push(Math.floor((Math.sqrt(n) % 1) * 4294967296));
      K.push(Math.floor((Math.cbrt(n) % 1) * 4294967296)); c++;
    }
    n++;
  }
  return {K, H0};
})();
function sha256(bytes){
  const {K, H0} = _SHA, H = H0.slice(), l = bytes.length, bits = l * 8;
  const total = ((l + 9 + 63) >> 6) << 6, buf = new Uint8Array(total);
  buf.set(bytes); buf[l] = 0x80;
  const dv = new DataView(buf.buffer);
  dv.setUint32(total - 8, Math.floor(bits / 4294967296)); dv.setUint32(total - 4, bits >>> 0);
  const w = new Uint32Array(64), rotr = (x, n) => (x >>> n) | (x << (32 - n));
  for(let o = 0; o < total; o += 64){
    for(let i = 0; i < 16; i++) w[i] = dv.getUint32(o + i*4);
    for(let i = 16; i < 64; i++){
      const s0 = rotr(w[i-15],7) ^ rotr(w[i-15],18) ^ (w[i-15] >>> 3);
      const s1 = rotr(w[i-2],17) ^ rotr(w[i-2],19) ^ (w[i-2] >>> 10);
      w[i] = (w[i-16] + s0 + w[i-7] + s1) >>> 0;
    }
    let [a,b,c,d,e,f,g,h] = H;
    for(let i = 0; i < 64; i++){
      const t1 = (h + (rotr(e,6) ^ rotr(e,11) ^ rotr(e,25)) + ((e & f) ^ (~e & g)) + K[i] + w[i]) >>> 0;
      const t2 = ((rotr(a,2) ^ rotr(a,13) ^ rotr(a,22)) + ((a & b) ^ (a & c) ^ (b & c))) >>> 0;
      h = g; g = f; f = e; e = (d + t1) >>> 0; d = c; c = b; b = a; a = (t1 + t2) >>> 0;
    }
    [a,b,c,d,e,f,g,h].forEach((v, i) => { H[i] = (H[i] + v) >>> 0; });
  }
  const out = new Uint8Array(32), odv = new DataView(out.buffer);
  H.forEach((v, i) => odv.setUint32(i*4, v));
  return out;
}
function hmacSha256(key, msg){
  const enc = new TextEncoder();
  let k = enc.encode(key); if(k.length > 64) k = sha256(k);
  const ipad = new Uint8Array(64), opad = new Uint8Array(64);
  for(let i = 0; i < 64; i++){ const b = k[i] || 0; ipad[i] = b ^ 0x36; opad[i] = b ^ 0x5c; }
  const m = enc.encode(msg), inner = new Uint8Array(64 + m.length);
  inner.set(ipad); inner.set(m, 64);
  const ih = sha256(inner), outer = new Uint8Array(96);
  outer.set(opad); outer.set(ih, 64);
  return sha256(outer);
}
const B32 = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';   // بدون O/I/0/1 لتفادي الالتباس
function toB32(bytes, nChars){
  let bits = 0, val = 0, out = '';
  for(const b of bytes){ val = (val << 8) | b; bits += 8; while(bits >= 5 && out.length < nChars){ out += B32[(val >>> (bits - 5)) & 31]; bits -= 5; } val &= 0xff; }
  return out;
}
const _grp = (s, n) => s.match(new RegExp('.{1,'+n+'}', 'g')).join('-');

/* ---------- رمز الجهاز (بصمة التثبيت) ---------- */
function _cookieGet(n){ try{ const m = document.cookie.match(new RegExp('(?:^|; )'+n+'=([^;]*)')); return m ? decodeURIComponent(m[1]) : null; }catch(e){ return null; } }
function _cookieSet(n, v){ try{ document.cookie = n+'='+encodeURIComponent(v)+'; max-age=315360000; path=/; SameSite=Lax'; }catch(e){} }
function getDeviceCode(){
  let c = null;
  try{ c = localStorage.getItem('zadam_device'); }catch(e){}
  if(!c || !/^\d{12}$/.test(c)) c = _cookieGet('zadam_device');
  if(!c || !/^\d{12}$/.test(c)){
    const r = new Uint32Array(3);
    if(typeof crypto !== 'undefined' && crypto.getRandomValues) crypto.getRandomValues(r);
    else for(let i = 0; i < 3; i++) r[i] = Math.floor(Math.random() * 4294967296);
    c = Array.from(r, x => String(x % 10000).padStart(4,'0')).join('');
  }
  try{ localStorage.setItem('zadam_device', c); }catch(e){}
  _cookieSet('zadam_device', c);
  return c;
}
function formatCode(c){ return c.match(/.{1,4}/g).join('-'); }

/* ---------- توليد المفتاح والتحقق ---------- */
function _serialNow(d){ d = d || new Date(_nowMs()); return d.getFullYear() * 100 + (d.getMonth() + 1); }
function _serialShift(s, delta){ let y = Math.floor(s / 100), m = (s % 100) + delta; while(m < 1){ m += 12; y--; } while(m > 12){ m -= 12; y++; } return y * 100 + m; }
function licenseKeyFor(device, scope, serial){
  return _grp(toB32(hmacSha256(CONFIG.LICENSE_SECRET, 'LIC|'+device+'|'+scope+'|'+serial), 15), 5);
}
function _recSig(device, scope, r){
  return toB32(hmacSha256(CONFIG.LICENSE_SECRET, 'REC|'+device+'|'+scope+'|'+r.k+'|'+r.ser+'|'+r.s), 10);
}

/* ---------- التخزين ---------- */
function _nowMs(){
  let seen = 0; try{ seen = +localStorage.getItem('zadam_seen') || 0; }catch(e){}
  const n = Math.max(Date.now(), seen);              // منع إرجاع ساعة الجهاز للخلف
  try{ localStorage.setItem('zadam_seen', String(n)); }catch(e){}
  return n;
}
function _loadLic(){ try{ return JSON.parse(localStorage.getItem('zadam_lic') || '{}') || {}; }catch(e){ return {}; } }
function _saveLic(o){ try{ localStorage.setItem('zadam_lic', JSON.stringify(o)); }catch(e){} }

function licStatus(scope){
  const r = _loadLic()[scope];
  if(!r) return {ok:false, reason:'none'};
  const dev = getDeviceCode();
  if(r.g !== _recSig(dev, scope, r) || r.k !== licenseKeyFor(dev, scope, r.ser)) return {ok:false, reason:'tampered'};
  const end = r.s + LIC.DAYS * 86400000, left = end - _nowMs();
  if(left <= 0) return {ok:false, reason:'expired', end};
  return {ok:true, end, days: Math.ceil(left / 86400000)};
}
function hasAnyLicense(){ return LIC_SCOPES.some(s => licStatus(s).ok); }

/* يعيد {ok, scope, end} أو {ok:false, reason} */
function activateKey(input){
  const key = String(input || '').toUpperCase().replace(/[^A-Z0-9]/g, '');
  if(key.length !== 15) return {ok:false, reason:'format'};
  const dev = getDeviceCode(), now = _serialNow();
  for(const scope of LIC_SCOPES){
    for(let d = 1; d >= -LIC.SERIAL_BACK; d--){
      const ser = _serialShift(now, d);
      if(licenseKeyFor(dev, scope, ser).replace(/-/g, '') !== key) continue;
      const store = _loadLic(), old = store[scope];
      if(old && ser <= old.ser) return {ok:false, reason:'used', scope};
      const cur = licStatus(scope);
      const start = cur.ok ? old.s + LIC.DAYS * 86400000 : _nowMs();   // التجديد المبكر يضيف سنة بعد الانتهاء الحالي
      const rec = {k: licenseKeyFor(dev, scope, ser), ser, s: start};
      rec.g = _recSig(dev, scope, rec);
      store[scope] = rec; _saveLic(store);
      return {ok:true, scope, end: start + LIC.DAYS * 86400000};
    }
  }
  return {ok:false, reason:'invalid'};
}
if(typeof module !== 'undefined') module.exports = {sha256, hmacSha256, toB32, licenseKeyFor, activateKey, licStatus, getDeviceCode, LIC_SCOPES, LIC, hasAnyLicense};
