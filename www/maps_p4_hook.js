/* فتح خرائط العلوم الفيزيائية 4AM (maps:'p4') من maps_p4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='p4'){openWebview('maps_p4.html','🗺️ خرائط العلوم الفيزيائية - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
