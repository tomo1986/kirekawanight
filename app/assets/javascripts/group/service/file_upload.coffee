angular.module 'bijyoZukanGroup'
.directive "fileModel",($parse) ->
  return  {
    restrict: 'A'
    link: (scope, element, attrs) ->
      model = $parse(attrs.fileModel)
      element.bind 'change', ->
        scope.$apply ->
          model.assign scope, element[0].files[0]
          return
        return
      return
  }
