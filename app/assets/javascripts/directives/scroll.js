grandma.directive("scroll", function ($window) {
  return function(scope, element, attrs) {
    scope.showNav = true;
    // scope.showNav = false;
    // angular.element($window).bind("scroll", function() {
    //   if (this.pageYOffset >= $($window).height() ) {
    //     scope.showNav = true;
    //   } else {
    //     scope.showNav = false;
    //   }
    // scope.$apply();
    //});
  };
});