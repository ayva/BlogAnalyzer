grandma.directive('loadedData', function () {
    return function ($scope, $element) {
      $element[0].addEventListener("loadeddata", function () {
        // $element[0].play();
      });
    };
});