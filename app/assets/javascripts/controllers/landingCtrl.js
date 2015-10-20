grandma.controller('landingCtrl', ['$scope', 'storage', '$timeout', function($scope, storage, $timeout) {

  $scope.landing = true;
  storage.getTotals();
  $scope.totals = storage.totals;

  $scope.checkBlog = storage.checkBlog

  // Initialize input field model
  $scope.blogUrl = "https://medium.com/@samplebloggername";
  $scope.showInput = false;
  $scope.formSubmitted = storage.formSubmitted;
  $scope.blogSubmitted = storage.checkBlogReply;

}]);