grandma.service('storage',['Restangular', function(Restangular){
  var obj = {};

  obj.totals = {};


  Restangular.all("authors").customGET('totals').then(function(response){
    obj.totals.TotalBloggers = response[0] ;
    obj.totals.TotalArticles = response[1] ;
    obj.totals.TotalIssues = response[2] ;

  });

  obj.bloggers = {};

  Restangular.all("authors").customGET('leaderboards').then(function(response){

    obj.bloggers.featuredBloggers = response[0];
    obj.bloggers.grandmaBloggers = response[1];

  });

  Restangular.all("authors").customGET('grouptop').then(function(response){

    obj.bloggers.groupBloggers = response;

  });

  Restangular.all('authors').getList().then(function(response){
    console.log(response)
    obj.bloggers.all = response;

  });



  return obj;

}]);