/* فتح خرائط التربية الإسلامية 4AM (maps:'i4') من maps_i4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='i4'){openWebview('maps_i4.html','🗺️ خرائط التربية الإسلامية - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
