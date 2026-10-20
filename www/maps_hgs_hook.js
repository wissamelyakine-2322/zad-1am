/* فتح خرائط التاريخ والجغرافيا للشعب العلمية (maps:'hgs') من maps_hgs.html. يُحمَّل بعد maps_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='hgs'){openWebview('maps_hgs.html','🗺️ خرائط التاريخ والجغرافيا');return}}catch(e){}
    return o(k);
  };
})();
