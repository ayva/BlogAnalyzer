grandma.controller('bloggerCtrl', ['$scope', '$stateParams', 'Restangular', function($scope, $stateParams, Restangular) {
  var username = $stateParams.username;
  var id = $stateParams.id;

   Restangular.one('authors', id).get().then(function(response){
    
    $scope.blogger = response;

    //Add arrow to show open and total errors
    var hints = $scope.blogger.author.hintstable;

    var hash={};
    for(var i=0; i<hints.length; i++) {
      if (!hash[hints[i].name]) {
        hash[hints[i].name] = [];
      }
      hash[hints[i].name].push([hints[i].count, hints[i].title]);
    }
    $scope.testhints =[];
    for(var h=0; h<Object.keys(hash).length; h++){
      $scope.testhints.push({name: Object.keys(hash)[h], hints: hash[Object.keys(hash)[h]]});
      
    }


    $scope.charts = {
      grammar: {
        labels: ["Enhancement", "Grammar","Spelling","Style","Sentence Structure","Plugiarism","Punctutation"],
        data: [ $scope.blogger.author.grammar.enhancement,
                $scope.blogger.author.grammar.grammar,
                $scope.blogger.author.grammar.spelling,
                $scope.blogger.author.grammar.style,
                $scope.blogger.author.grammar.sentenceStructure,
                $scope.blogger.author.grammar.plagiarism,
                $scope.blogger.author.grammar.punctuation],
      },
      avgErrors: {
        labels: ["Errors", "Articles"],
        data: [$scope.blogger.author.totalerrors, $scope.blogger.author.totalposts],
      },
      errorsPerWords: {
        labels: ["Errors", "Words"],
        data: [$scope.blogger.author.totalerrors, $scope.blogger.author.totalwords],
      }
    };
  });





}]);