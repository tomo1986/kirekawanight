angular.module 'bijyoZukanAdmin'
.directive 'navDirective', ($state,$rootScope,user) ->
  NavController = () ->
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
        window.location.reload()
      )

    return
  linkFunc = (scope, el, attr, vm) ->
    scope.vm.active = $state.current.active_menu
    $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      scope.vm.active = toState.active_menu
    )
    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/block/nav.html"
    controller: NavController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
