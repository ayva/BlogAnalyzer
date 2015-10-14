grandma.controller('boardsCtrl', ['$scope', '$timeout', 'storage', function($scope, $timeout, storage){


  $scope.blogUrl = "https://medium.com/@sampleblogname";
  
  //Scores for magazines
  $scope.magazines = {  bbc: 100-2.11,
                        cnn: 100-1.72,
                        newyorker: 100-1.4,
                        newyorktimes: 100-1.81};


  //Leaderboards and 4 bloggers at the bottom, best in a grammar group
  storage.getBloggers();
  $scope.bloggers = storage.bloggers;

  $scope.checkBlog = function(){
    $timeout(function(){
      $scope.showInput = false;
      storage.formSubmitted.b = false;},
      7000);
    storage.checkBlog($scope.blogUrl);
  };
  $scope.formSubmitted = storage.formSubmitted;
  $scope.blogSubmitted = storage.checkBlogReply;
  

  
}]);

//Custom validation for url
grandma.directive('medium',function(){
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl){
      ctrl.$validators.medium = function(modelValue, viewValue){
        if(ctrl.$isEmpty(modelValue)){
           // consider empty models to be invalid
          return false;
        }
        if(modelValue.toLowerCase().includes('https://medium.com/@')){
          return true;
        }

        return false;
      };
    }
  };
});

