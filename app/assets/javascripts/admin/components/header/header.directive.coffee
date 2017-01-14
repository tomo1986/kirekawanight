angular.module 'bijyoZukanAdmin'
.directive 'headerDirective',  ->
  HeaderController = ($state,api) ->
    vm = this

    vm.onLogout = ->
      api.postPromise('/api/admin/logout',{}).then((res) ->
        window.location.reload()
      )

    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
