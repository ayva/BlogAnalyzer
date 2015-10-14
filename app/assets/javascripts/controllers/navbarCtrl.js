grandma.controller('navbarCtrl', ['$scope', '$location', '$state', 'storage',
                                  function($scope, $location, $state, storage) {

  if ($location.path() === '/')
    $scope.landing = true;

  if ($location.path() ==='/leaderboards') $scope.leaderboards = true;
  storage.getAll();
  $scope.users = storage.bloggers;

  $scope.go = function(user) {
    $state.go("blogger", {username: user.username, id: user.id });
  };


}]);