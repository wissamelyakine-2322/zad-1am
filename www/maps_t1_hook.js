/* فتح خرائط التكنولوجيا 1AS (maps:'t1') من maps_t1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_p1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='t1'){openWebview('maps_t1.html','🗺️ خرائط التكنولوجيا - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();
