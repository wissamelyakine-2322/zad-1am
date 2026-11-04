/* فتح خرائط اللغة الفرنسية 1AS (maps:'fr1') من maps_fr1.html؛ يُحمَّل بعد maps_is1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='fr1'){
      openWebview('maps_fr1.html','🗺️ خرائط اللغة الفرنسية - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

