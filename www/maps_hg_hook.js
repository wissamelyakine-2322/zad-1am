/* فتح خرائط التاريخ والجغرافيا (maps:'hg') من maps_hg.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='hg'){openWebview('maps_hg.html','🗺️ خرائط التاريخ والجغرافيا');return}}catch(e){}
    return o(k);
  };
})();
