grandma.directive("arrowScroll", function ($window) {
  return function(scope, element, attrs) {

    angular.element($window).bind("scroll", function() {
      if (this.pageYOffset >= 100 ) {
        $(".hint-arrow").css({
          '-webkit-transform' : 'translate3d(0,300px,0)',
          'transform'         : 'translate3d(0,300px,0)'
        });
      } else {
        $(".hint-arrow").css({
          '-webkit-transform' : 'translate3d(0,40px,0)',
          'transform'         : 'translate3d(0,40px,0)'
        });
      }
    scope.$apply();
    });
  };
});