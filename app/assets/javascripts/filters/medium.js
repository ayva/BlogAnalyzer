//Custom validation for url
grandma.directive('medium',function(){
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl){
      ctrl.$validators.medium = function(modelValue, viewValue){

        if (ctrl.$isEmpty(modelValue)) return false;

        if (viewValue === "https://medium.com/@samplebloggername") return false;

        // if(viewValue.toLowerCase().includes('https://medium.com/@')){
        //   return true;
        // }

        return true;
      };
    }
  };
});