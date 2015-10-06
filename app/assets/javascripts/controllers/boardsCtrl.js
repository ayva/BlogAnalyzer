grandma.controller('boardsCtrl', ['$scope', function($scope){

  //Scores for magazines

  $scope.magazines = {  bbc: 97,
                        cnn: 99.9,
                        newyorker: 99.8,
                        newyorktimes: 100};

  //Left leaderboard with today's bloggers
  $scope.featuredBloggers = [
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        name: 'Anna Harari',
                        score: 99.9 },
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/0*B04L2Ma1UbOvo7xg.jpeg',
                        name: 'Gavin Sheridan',
                        score: 91.5}
                    ];
   //Right leaderboard with bloggers of all times
  $scope.grandmaBloggers = [
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        name: 'Anna Harari',
                        score: 99.9 },
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/0*B04L2Ma1UbOvo7xg.jpeg',
                        name: 'Gavin Sheridan',
                        score: 91.5}
                    ];
    //4 bloggers at the bottom, best in a grammar group
    //description is from about under image on blog page
  $scope.groupBloggers = [
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*3R6E3UiBHI5YPPZ2YPA4bg.jpeg',
                        name: 'Anna Harari',
                        score: 99.9 ,
                        description: "A Los Angeles based writer/director",
                        groupname: 'Grammar'},
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/0*B04L2Ma1UbOvo7xg.jpeg',
                        name: 'Gavin Sheridan',
                        score: 91.5,
                        description: "Founder/CEO @Vizlegal | Advisor @DollarEagle | FOI, journalism, law, data | Former Innovation Dir @Storyful | Dublin, Ireland",
                        groupname: 'Punctuation'},
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*Cy0LBwZNc0Xjffyqv_37lA.png',
                        name: 'Aaron Bleyaert',
                        score: 95.3,
                        description: "I’m Always Home. I’m Uncool.",
                        groupname: 'Style' },
                      { pic: 'https://cdn-images-1.medium.com/fit/c/120/120/1*XuKabEs8iEuneJxjJJ5JXw.jpeg',
                        name: 'Sloane Crosley',
                        score: 98.7,
                        description: "Author of I Was Told There’d Be Cake, How Did You Get This Number, Up The Down Volcano (an e-book) and a debut novel, The Clasp, out in October.",
                        groupname: 'Structure'}

                    ];
}]);