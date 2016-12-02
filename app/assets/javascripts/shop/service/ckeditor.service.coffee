angular.module 'bijyoZukanShop'
.directive 'ckeditorService', () ->
  require: '?ngModel'
  link: (scope, elm, attr, ngModel) ->
    ck = CKEDITOR.replace(elm[0])
    console.log(ck)
    updateModel = ->
      scope.$apply ->
        ngModel.$setViewValue ck.getData()
        return
      return

    if !ngModel
      return
    ck.on 'instanceReady', ->
      ck.setData ngModel.$viewValue
      return
    ck.on 'change', updateModel
    ck.on 'key', updateModel
    ck.on 'dataReady', updateModel

    ngModel.$render = (value) ->
      ck.setData ngModel.$viewValue
      return

    return