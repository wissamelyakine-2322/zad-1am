/* فتح خرائط التاريخ 4AM (maps:'h4') من maps_h4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_i4_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='h4'){openWebview('maps_h4.html','🗺️ خرائط التاريخ - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
