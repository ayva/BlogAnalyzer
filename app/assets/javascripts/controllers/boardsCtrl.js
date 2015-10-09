grandma.controller('boardsCtrl', ['$scope',  'storage', function($scope,  storage){

  //Scores for magazines

  $scope.magazines = {  bbc: 97,
                        cnn: 99.9,
                        newyorker: 99.8,
                        newyorktimes: 100};


    //4 bloggers at the bottom, best in a grammar group
    $scope.bloggers = storage.bloggers;

}]);