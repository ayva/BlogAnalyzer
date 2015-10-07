grandma.controller('bloggerCtrl', ['$scope', '$stateParams',function($scope, $stateParams) {
  var username = $stateParams.username;
  
  //Need to get blogger by username 
  $scope.blogger = {    pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        name: 'Anna Harari',
                        username: 'annaharari',
                        score: 99.9 ,
                        articles: 32,
                        errors: 4,
                        twitter: 'https://twitter.com/lessig',
                        facebook: 'https://www.facebook.com/lessig'

                      };
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

                  ]
}]);