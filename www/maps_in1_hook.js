/* فتح خرائط الإعلام الآلي 1AS (maps:'in1') من maps_in1.html؛ يُحمَّل بعد maps_en1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='in1'){
      openWebview('maps_in1.html','🗺️ خرائط الإعلام الآلي - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

