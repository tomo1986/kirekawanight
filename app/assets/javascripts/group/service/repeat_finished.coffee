angular.module 'bijyoZukanGroup'
.directive "repeatFinished",($timeout) ->
  return  {
    restrict: 'A'
    link: (scope, element, attrs) ->
      if scope.$last
        $timeout ->
          scope.$parent[attrs.repeatFinished]()
          return
      return
  }
