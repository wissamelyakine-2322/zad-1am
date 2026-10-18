/* الأيقونة الخامسة: الخرائط الذهنية — تُفعَّل للمواد التي تحمل الحقل maps في بياناتها */
function hasMaps(k){try{var d=getSubjectData(k);return !!(d&&d.maps)}catch(e){return false}}
function openMaps(k){var d=getSubjectData(k);if(d&&d.maps)openWebview('maps.html#'+d.maps,'🗺️ الخرائط الذهنية')}
