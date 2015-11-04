grandma.service('storage',['$http','Restangular', '$timeout', function($http, Restangular, $timeout){
  var obj = {};

  obj.totals = {};

  obj.checkBlogReply = {};
  obj.formSubmitted ={ bool: false };

  obj.checkBlog = function(url){
    obj.formSubmitted.bool = true;
    obj.checkBlogReply.message = "We are processing your request...";
    $timeout(function(){ obj.formSubmitted.bool = false; }, 5000);

    Restangular.all('authors').customPOST({url: url}, 'newblogger' )
      .then(function(response){
        obj.checkBlogReply.message = response;
      }, function(){
        obj.checkBlogReply.message = "Please check blog url and try again.";
      });

  };


  obj.getTotals = function(){
    Restangular.all("authors").customGET('totals').then(function(response){
      obj.totals.TotalBloggers = response[0] ;
      obj.totals.TotalArticles = response[1] ;
      obj.totals.TotalIssues = response[2] ;

    });
  };


  obj.bloggers = {};
  obj.getBloggers = function(){

    Restangular.all("authors").customGET('leaderboards').then(function(response){

      obj.bloggers.featuredBloggers = response[0];
      obj.bloggers.grandmaBloggers = response[1];

    });

    Restangular.all("authors").customGET('grouptop').then(function(response){

      obj.bloggers.groupBloggers = response;

    });
  };

  obj.getAll = function(){
    Restangular.all('authors').getList().then(function(response){

    obj.bloggers.all = response;

    });
  };



  return obj;

}]);
