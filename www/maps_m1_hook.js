/* فتح خرائط الرياضيات 1AS (maps:'m1') من maps_m1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_s1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='m1'){openWebview('maps_m1.html','🗺️ خرائط الرياضيات - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();
