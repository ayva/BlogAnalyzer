grandma.service('storage',['$http','Restangular', function($http,Restangular){
  var obj = {};

  obj.totals = {};

  obj.checkBlogReply = {};
  obj.formSubmitted ={};
  obj.formSubmitted.b = false;
  obj.checkBlog = function(url){
    
    if(url.toLowerCase().includes("https://medium.com/@")){
      obj.formSubmitted.b = true;
      Restangular.all('authors').customPOST({url: url}, 'newblogger' ).then(function(response){
                obj.checkBlogReply.message = response;
              }, function(){
                obj.checkBlogReply.message = "Please check blog url and try again.";
              });
      //XMLHttpRequest cannot load https://medium.com/@sampleblognam. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:3000' is therefore not allowed access. The response had HTTP status code 401.
      // $http({
      //   method: 'GET',
      //   url: url,
      //   headers: { "Access-Control-Allow-Origin": "*",
      //     "Access-Control-Allow-Methods": "GET",
      //             "Content-Type":"application/json",
      //             'Accept': 'application/json'
      //   }
      // }).then(function successCallback(){
      //   Restangular.all('authors').customPOST({url: url}, 'newblogger' ).then(function(response){
      //           obj.checkBlogReply.message = response;
      //         });
      // }, function errorCallback(){
      //   obj.checkBlogReply.message = "Please provide existing Medium blog";
      // });

    } else {
      obj.checkBlogReply.message = "Please provide blog on https://medium.com/";
    }

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