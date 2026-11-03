/* فتح خرائط التاريخ والجغرافيا 1AS (maps:'hg1') من maps_hg1.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_t1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var KH=["his-geo"],KG=["his-geo"];
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='hg1'){
      var hH=KH.indexOf(k)>=0,hG=KG.indexOf(k)>=0;
      var h=(hH&&hG)?'':(hH?'#h':'#g');
      openWebview('maps_hg1.html'+h,'🗺️ خرائط التاريخ والجغرافيا - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

