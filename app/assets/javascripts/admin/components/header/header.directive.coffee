angular.module 'bijyoZukanAdmin'
.directive 'headerDirective',  ->
  HeaderController = ($state,api,user) ->
    vm = this

    vm.onLogout = ->
      user.clear().then((res)->
        window.location.reload()
      )

    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
