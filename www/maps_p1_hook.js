/* فتح خرائط العلوم الفيزيائية 1AS (maps:'p1') من maps_p1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_m1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='p1'){openWebview('maps_p1.html','🗺️ خرائط العلوم الفيزيائية - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();
