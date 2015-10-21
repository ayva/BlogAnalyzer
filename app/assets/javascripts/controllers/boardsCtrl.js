grandma.controller('boardsCtrl', ['$scope', '$timeout', 'storage', function($scope, $timeout, storage){

  // Initialize input field model
  $scope.blogUrl = "https://medium.com/@samplebloggername";

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
      5000);
    storage.checkBlog($scope.blogUrl);
  };

  $scope.formSubmitted = storage.formSubmitted;
  $scope.blogSubmitted = storage.checkBlogReply;

}]);
