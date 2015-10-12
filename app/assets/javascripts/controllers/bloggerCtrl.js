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




  $scope.charts = {
    grammar: {
      labels: ["Punctutation", "Style"],
      data: [120, 130],
    },
    avgErrors: {
      labels: ["Errors", "Correct Grammar"],
      data: [5, (100 - 5)],
    },
    errorsPerWords: {
      labels: ["Errors", "Correct Grammar"],
      data: [3, (100 - 3)],
    }
  }


}]);