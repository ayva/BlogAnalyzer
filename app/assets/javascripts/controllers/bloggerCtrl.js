grandma.controller('bloggerCtrl', ['$scope', '$stateParams', 'Restangular', function($scope, $stateParams, Restangular) {
  var username = $stateParams.username;
  var id = $stateParams.id;

   Restangular.one('authors', id).get().then(function(response){
    
    $scope.blogger = response;
    console.log(response.author.totalposts)
  });


        // <tr ng-repeat='hint in blogger.table'>
        //   <td>{{hint.total}}</td>
        //   <td>{{hint.title}}</td>
        //   <td>{{hint.groupname}}</td>





  $scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales"];
  $scope.data = [300, 500, 100];

}]);