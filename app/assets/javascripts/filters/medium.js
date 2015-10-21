//Custom validation for url
grandma.directive('medium',function(){
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl){
      ctrl.$validators.medium = function(modelValue, viewValue){

        if(ctrl.$isEmpty(modelValue)){
           // consider empty models to be invalid
          return false;
        }

        if (modelValue === "https://medium.com/@samplebloggername") return false;

        if(modelValue.toLowerCase().includes('https://medium.com/@')){
          return true;
        }

        return false;
      };
    }
  };
});