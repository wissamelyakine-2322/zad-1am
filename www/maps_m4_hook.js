/* فتح خرائط رياضيات 3AS آداب ولغات (maps:'m4') من maps_m4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='m4'){openWebview('maps_m4.html','🗺️ خرائط الرياضيات - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
