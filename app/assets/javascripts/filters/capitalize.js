grandma.filter('capitalize', function(){
  return function(collection, element){
    if (collection){
      return collection.split(" ").map(function(el){
        return el.charAt(0).toUpperCase() + el.substr(1).toLowerCase();
      }).join(" ");
    }
  };
});
