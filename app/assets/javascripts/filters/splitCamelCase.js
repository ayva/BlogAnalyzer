grandma.filter('splitCamelCase', function(){
  return function(collection, element){
    if (collection){
      return collection.replace(/([A-Z])/g, ' $1').substring(1);
    }
  };
});
