angular.module 'bijyoZukanShop'
.directive 'imageDirective',($timeout,$interval,modalService) ->
  ImageController = ($scope,$state,$rootScope,$location, $timeout,$interval) ->
    vm = this
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.vm.imgStyle = {}
    scope.vm.img = new Image()


    scope.$watch("vm.imgUrl", (val) ->
      scope.vm.img.src = val if val.length > 0
    )
    scope.vm.img.onload = ()->
      el.find('img').attr('src', scope.vm.img.src)
      $timeout ->
        scope.vm.makeStyle()
      ,100

    scope.vm.makeStyle = () ->
      scope.vm.imgStyle  = {}
      maxW = $('.' + scope.vm.parentClass).width()
      maxH = $('.' + scope.vm.parentClass).height()

      offsetW = scope.vm.img.width
      offsetH = scope.vm.img.height
      cal = offsetW/(offsetH/maxH)
      if offsetW > maxW && offsetH > maxH
        if offsetW > offsetH & cal > maxW
          scope.vm.imgStyle["maxHeight"] =  maxH + 'px'
          left = (maxW - cal)/2
          scope.vm.imgStyle['left']= left
          return
        else if offsetH >= offsetW || cal < maxW
          scope.vm.imgStyle["maxWidth"] =  maxW + 'px'
          return
      else
        left = (maxW - offsetW)/2
        scope.vm.imgStyle['left']= left

    $( window ).on('resize', () ->
      $timeout ->
        scope.vm.makeStyle()
      ,100
    )

  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/shop/tpl/block/image.html"
    controller: ImageController
    controllerAs: 'vm'
    scope:{
      item:'='
      htmlId: '@'
      imgUrl: "@"
      parentClass: '@'
      callBack:'='
    }
    bindToController: true
    link: linkFunc
