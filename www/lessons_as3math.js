/* دروس رياضيات 3AS آداب وفلسفة + لغات أجنبية، بحسب التدرج السنوي. يُحمَّل بعد lessons*.js و m3_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof M3_DATA==='undefined')return;
  var A=LESSONS_DB.AS3; if(!A)return;
  var SUB={'0':'₀','1':'₁','2':'₂','3':'₃','4':'₄','5':'₅','6':'₆','7':'₇','8':'₈','9':'₉','+':'₊','-':'₋','=':'₌','(':'₍',')':'₎','a':'ₐ','e':'ₑ','h':'ₕ','i':'ᵢ','j':'ⱼ','k':'ₖ','l':'ₗ','m':'ₘ','n':'ₙ','o':'ₒ','p':'ₚ','r':'ᵣ','s':'ₛ','t':'ₜ','u':'ᵤ','v':'ᵥ','x':'ₓ'};
  var SUP={'0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹','+':'⁺','-':'⁻','=':'⁼','(':'⁽',')':'⁾','n':'ⁿ','i':'ⁱ','k':'ᵏ','p':'ᵖ','a':'ᵃ','m':'ᵐ'};
  function conv(s,map,pre){var o='';for(var i=0;i<s.length;i++){if(!map[s[i]])return pre+'('+s+')';o+=map[s[i]]}return o}
  function fx(s){
    return String(s).replace(/`/g,'').replace(/_\{([^}]*)\}/g,function(m,a){return conv(a,SUB,'_')}).replace(/\^\{([^}]*)\}/g,function(m,a){return conv(a,SUP,'^')});
  }
  function text(c){
    var t=[];
    t.push('▸ التدرج السنوي');t.push('• '+c.wk+' من 27 (السنة الثالثة ثانوي آداب وفلسفة ولغات أجنبية)');
    c.B.forEach(function(b){t.push('▸ '+fx(b[0]));b[1].forEach(function(x){t.push('• '+fx(x))})});
    t.push('▸ للحفظ');t.push('• '+fx(c.K));
    t.push('▸ طرق وقواعد');c.M.forEach(function(x){t.push('• '+fx(x))});
    t.push('▸ شرح مبسط');t.push('• '+fx(c.X));
    t.push('▸ تمارين محلولة');
    c.EX.forEach(function(e,j){t.push('• تمرين '+(j+1)+': '+fx(e[0]));t.push('• الحل: '+fx(e[1]))});
    return t.join('\n');
  }
  var L=M3_DATA.map(function(c){var k=c.n<10?'0'+c.n:''+c.n;return {title:k+'. '+fx(c.t),content:text(c)}});
  var hit=[];
  Object.keys(A).forEach(function(k){
    var o=A[k]; if(!o||typeof o!=='object')return;
    var nm=String(o.name||''), cnt=(o.lessons||[]).length;
    if(o.maps==='m3'){o.lessons=L;hit.push(k);return}
    if(o.maps==='math'||(nm.indexOf('الرياضيات')>=0&&cnt===21&&!/^(ge_|tm_)/.test(k))){o.lessons=L;o.maps='m3';hit.push(k)}
  });
  try{console.log('as3math keys:',hit.join(','))}catch(e){}
})();
