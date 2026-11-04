/* فتح خرائط اللغة الإنجليزية 1AS (maps:'en1') من maps_en1.html؛ يُحمَّل بعد maps_fr1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='en1'){
      openWebview('maps_en1.html','🗺️ خرائط اللغة الإنجليزية - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

