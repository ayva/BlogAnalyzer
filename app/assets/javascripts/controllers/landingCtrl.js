grandma.controller('landingCtrl', ['$scope', 'storage', function($scope, storage) {

  $scope.landing = true;
  storage.getTotals();
  $scope.totals = storage.totals;






}]);