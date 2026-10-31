/* دروس علوم الطبيعة والحياة للسنة الأولى ثانوي (جذع مشترك علوم وتكنولوجيا). يُحمَّل بعد lessons.js و s1_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof S1_DATA==='undefined')return;
  var KEY='sciences';
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
    t.push('▸ المرجع');t.push('• كتاب علوم الطبيعة والحياة للسنة الأولى ثانوي جذع مشترك علوم وتكنولوجيا — الدرس '+c.m+': '+(S1_MQ[c.m]||'')+' — ملخص بتصرف');
    return t.join('\n');
  }
  var L=S1_DATA.map(function(c){var k=c.n<10?'0'+c.n:''+c.n;return {title:k+'. '+fx(c.t),content:text(c)}});
  var A=LESSONS_DB.AS1=LESSONS_DB.AS1||{};
  var o=A[KEY]||{};
  o.name=o.name||'علوم الطبيعة والحياة';
  o.lessons=L;
  o.maps='s1';
  A[KEY]=o;
})();
