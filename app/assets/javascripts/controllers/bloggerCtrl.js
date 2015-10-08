grandma.controller('bloggerCtrl', ['$scope', '$stateParams', 'Restangular', function($scope, $stateParams, Restangular) {
  var username = $stateParams.username;
  var id = $stateParams.id;

   Restangular.one('authors', id).get().then(function(response){
    $scope.blogger = response;
  });


  //Need to get hint for this user
  $scope.hints = [{
                  amount: 6,
                  text: "The noun phrase -great software- seems to be missing a determiner before it. Consider adding an article",
                  group: "grammar"
                  },
                  {
                  amount: 3,
                  text: "It appears that you are missing a comma before the coordinating conjunction -and- in a compound sentence. consider adding a comma.",
                  group: "punctuation"
                  },

                  ];

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