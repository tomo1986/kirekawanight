angular.module 'bijyoZukanGroup'
.directive 'headerDirective',  ->
  HeaderController = ($state,api,user) ->
    vm = this
    vm.isActive = false
    vm.isParentActive = false
    vm.isParentChild = false
    vm.eventOpenParent = () ->
      vm.isParentActive = !vm.isParentActive
      vm.isParentChild = false if !vm.isParentActive
    vm.eventOpenchild = ->
      vm.isParentChild = !vm.isParentChild

    vm.eventCalled = ->
      vm.isActive = !vm.isActive

    vm.onLogout = ->
      user.clear().then((res)->
        console.log("soeya")
        window.location.reload()
      )

    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/group/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
