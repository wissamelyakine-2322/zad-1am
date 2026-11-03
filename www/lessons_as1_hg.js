/* دروس التاريخ والجغرافيا للسنة الأولى ثانوي. يُحمَّل بعد lessons.js و hg1_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof HG1_DATA==='undefined')return;
  var KH=["his-geo"],KG=["his-geo"];
  var SUB={'0':'₀','1':'₁','2':'₂','3':'₃','4':'₄','5':'₅','6':'₆','7':'₇','8':'₈','9':'₉','+':'₊','-':'₋','=':'₌','(':'₍',')':'₎','a':'ₐ','e':'ₑ','h':'ₕ','i':'ᵢ','j':'ⱼ','k':'ₖ','l':'ₗ','m':'ₘ','n':'ₙ','o':'ₒ','p':'ₚ','r':'ᵣ','s':'ₛ','t':'ₜ','u':'ᵤ','v':'ᵥ','x':'ₓ'};
  var SUP={'0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹','+':'⁺','-':'⁻','=':'⁼','(':'⁽',')':'⁾','n':'ⁿ','i':'ⁱ','k':'ᵏ','p':'ᵖ','a':'ᵃ','m':'ᵐ'};
  function conv(s,map,pre){var o='';for(var i=0;i<s.length;i++){if(!map[s[i]])return pre+'('+s+')';o+=map[s[i]]}return o}
  function fx(s){
    return String(s).replace(/`/g,'').replace(/_\{([^}]*)\}/g,function(m,a){return conv(a,SUB,'_')}).replace(/\^\{([^}]*)\}/g,function(m,a){return conv(a,SUP,'^')});
  }
  function text(c){
    var t=[];
    c.B.forEach(function(b){t.push('▸ '+fx(b[0]));b[1].forEach(function(x){t.push('• '+fx(x))})});
    t.push('▸ للحفظ');t.push('• '+fx(c.K));
    t.push('▸ طرق وقواعد');c.M.forEach(function(x){t.push('• '+fx(x))});
    t.push('▸ شرح مبسط');t.push('• '+fx(c.X));
    t.push('▸ تمارين محلولة');
    c.EX.forEach(function(e,j){t.push('• تمرين '+(j+1)+': '+fx(e[0]));t.push('• الحل: '+fx(e[1]))});
    t.push('▸ المرجع');t.push('• كتاب '+(c.s==='h'?'التاريخ':'الجغرافيا')+' للسنة الأولى ثانوي — '+(HG1_MQ[c.k]||'')+' — ملخص بتصرف');
    return t.join('\n');
  }
  var A=LESSONS_DB.AS1=LESSONS_DB.AS1||{};
  var keys={};KH.forEach(function(k){keys[k]=1});KG.forEach(function(k){keys[k]=1});
  Object.keys(keys).forEach(function(KEY){
    var hH=KH.indexOf(KEY)>=0,hG=KG.indexOf(KEY)>=0,both=hH&&hG;
    var L=[];
    HG1_DATA.forEach(function(c){
      if((c.s==='h'&&!hH)||(c.s==='g'&&!hG))return;
      var k=c.n<10?'0'+c.n:''+c.n;
      L.push({title:(both?(c.s==='h'?'📜 ت ':'🌍 ج '):'')+k+'. '+fx(c.t),content:text(c)});
    });
    var o=A[KEY]||{};
    o.name=o.name||(both?'التاريخ والجغرافيا':hH?'التاريخ':'الجغرافيا');
    o.lessons=L;
    o.maps='hg1';
    A[KEY]=o;
  });
})();
