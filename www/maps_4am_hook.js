/* فتح خرائط العربية للسنة الرابعة متوسط (maps:'ar4') من maps_ar4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='ar4'){openWebview('maps_ar4.html','🗺️ خرائط العربية - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
