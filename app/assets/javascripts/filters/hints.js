grandma.filter('hints_by_name', function(){
  return function(collection, name){
    if(!name){return false;}

    var filteredCollection =[];

    angular.forEach(collection, function(hint){
      if(hint.name == 'name'){
        filteredCollection.push(hint);
      }
    });

    return filteredCollection;
  };
});

grandma.filter('rawHtml', ['$sce', function($sce){
  return function(val) {
    return $sce.trustAsHtml(val);
  };
}]);