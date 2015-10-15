grandma.controller('bloggerCtrl', ['$scope', '$stateParams', '$location', 'Restangular', function($scope, $stateParams, $location, Restangular) {
  var username = $stateParams.username;
  var id = $stateParams.id;

    $scope.magazines = {newyorker: 1.4,
                        cnn: 1.72,
                        newyorktimes: 1.81,
                        bbc: 2.11};

   Restangular.one('authors', id).get().then(function(response){
    
    $scope.blogger = response;
    
    var text=encodeURIComponent($scope.blogger.full_name+' in '+$scope.blogger.rating+'% best bloggers according to Grandma check.');
    $scope.twitterUrl = 'http://twitter.com/share?via=GrandmaCheck&hashtags= grammar&url=http%3A%2F%2Fgrandma.space&text='+text+'.';
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
      $scope.testhints.push({name: Object.keys(hash)[h], amount: hash[Object.keys(hash)[h]].length, hints: hash[Object.keys(hash)[h]]});
      
    }

    
  $scope.done = function(){
      $("#canvasimg").attr("src", $("#grammar-structure").get(0).toDataURL("img/png"));
  };

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
        options: {onAnimationComplete: $scope.done}
      },
      avgErrors: {
        labels: ["Errors", "Articles"],
        data: [$scope.blogger.author.totalerrors, $scope.blogger.author.totalposts]
        
      },
      errorsPerWords: {
        labels: ["Errors", "Words"],
        data: [$scope.blogger.author.totalerrors*10, $scope.blogger.author.totalwords]
      }
    };
  }, function(){
    $location.path('/');
  });





}]);