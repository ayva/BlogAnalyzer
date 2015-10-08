grandma.controller('navbarCtrl', ['$scope', '$location', '$state', 'storage',
                                  function($scope, $location, $state, storage) {

  if ($location.path() === '/')
    $scope.landing = true;

  $scope.users = [
    {username: "annaharari", id: 1},
    {username: "gavinsheridan", id: 2}
  ];


  // $scope.users = storage.bloggers.all;

  $scope.go = function(user) {
    console.log(user);
    $state.go("blogger", {username: user.username, id: user.id })
  }


}]);