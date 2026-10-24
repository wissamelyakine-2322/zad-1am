/* دروس اللغة العربية - الرابعة متوسط (المقاطع 1-8). يُحمَّل بعد lessons.js و ar4_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof AR4_DATA==='undefined')return;
  var KEY='arabic';
  function text(c){
    var t=[];
    c.B.forEach(function(b){t.push('▸ '+b[0]);b[1].forEach(function(x){t.push('• '+x)})});
    t.push('▸ للحفظ');t.push('• '+c.K);
    t.push('▸ طرق وقواعد');c.M.forEach(function(x){t.push('• '+x)});
    t.push('▸ شرح مبسط');t.push('• '+c.X);
    t.push('▸ تمارين محلولة');
    c.EX.forEach(function(e,j){t.push('• تمرين '+(j+1)+': '+e[0]);t.push('• الحل: '+e[1])});
    t.push('▸ المرجع');t.push('• كتاب اللغة العربية للسنة الرابعة متوسط (الشهاب 2019) '+c.pg+' — ملخص بتصرف');
    return t.join('\n');
  }
  var L=AR4_DATA.map(function(c){return {title:'م'+c.m+' · '+c.t,content:text(c)}});
  var A=LESSONS_DB['4AM']=LESSONS_DB['4AM']||{};
  var o=A[KEY]||{};
  o.name=o.name||'اللغة العربية';
  o.lessons=(o.lessons||[]).concat(L);
  o.maps='ar4';
  A[KEY]=o;
})();
