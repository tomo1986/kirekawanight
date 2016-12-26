angular.module 'bisyoujoZukanNight'
.directive 'headerDirective',  (api) ->
  HeaderController = ($state,api, customerService,$timeout) ->
    vm = this
    vm.init = ->
      vm.isActive = false
      vm.isParentActive = false
      vm.isParentChild = false
      vm.loginCustomer = customerService.getLoginCustomer()
      api.getPromise('/api/front/api20',{}).then((res) ->
        vm.userCount = res.data.user_count
        vm.shopCount = res.data.shop_count
      )

    vm.onClickedLogout = ->
      customerService.clear().then((res)->
        window.location.reload()
      )

    vm.eventOpenParent =  ->
      vm.isParentActive = !vm.isParentActive
      vm.isParentChild = false if !vm.isParentActive

    vm.eventOpenchild = ->
      vm.isParentChild = !vm.isParentChild

    vm.eventCalled = ->
      vm.isActive = !vm.isActive
      console.log(vm.isActive)

    vm.onClosed = ->
      vm.isActive = !vm.isActive

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.vm.userCount = vm.userCount
    scope.vm.shopCount = vm.shopCount
    return

  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
