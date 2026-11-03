/* فتح خرائط العلوم الإسلامية 1AS (maps:'is1') من maps_is1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='is1'){
      openWebview('maps_is1.html','🗺️ خرائط العلوم الإسلامية - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

