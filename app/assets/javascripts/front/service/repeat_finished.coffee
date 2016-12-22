angular.module 'bisyoujoZukanNight'
.directive "repeatFinished",($timeout) ->
  return  {
    restrict: 'A'
    link: (scope, element, attrs) ->
      console.log(attrs)
      if scope.$last
        $timeout ->
          scope.$parent.$parent.vm[attrs.repeatFinished]()
          return
      return
  }
