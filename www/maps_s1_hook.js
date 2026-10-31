/* فتح خرائط علوم الطبيعة 1AS (maps:'s1') من maps_s1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='s1'){openWebview('maps_s1.html','🗺️ خرائط علوم الطبيعة والحياة - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();
