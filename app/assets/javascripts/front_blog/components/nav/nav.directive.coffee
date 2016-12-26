angular.module 'bisyoujoZukanNight'
.directive 'navDirective', ($state,$rootScope) ->
  NavController = (api, customerService,$timeout) ->
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
    console.log(scope)
    scope.vm.active = $state.current.active_menu
    $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      scope.vm.active = toState.active_menu
    )
    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/nav.html"
    controller: NavController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
