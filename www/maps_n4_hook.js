/* فتح خرائط علوم الطبيعة 4AM (maps:'n4') من maps_n4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='n4'){openWebview('maps_n4.html','🗺️ خرائط علوم الطبيعة والحياة - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
