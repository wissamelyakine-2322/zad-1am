/* فتح خرائط رياضيات 3AS آداب ولغات (maps:'m3') من maps_m3.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='m3'){openWebview('maps_m3.html','🗺️ خرائط الرياضيات - 3AS آداب ولغات');return}}catch(e){}
    return o(k);
  };
})();
