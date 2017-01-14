angular.module 'bijyoZukanAdmin'
.directive 'adminIndexDirective',  ->
  AdminIndexController = ($state, api,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'管理者一覧',link:''}]
      vm.admins = []
      vm.getAdmins()

    vm.getAdmins = ->
      api.getPromise('/api/admin/api70',{}).then((res) ->
        vm.admins = res.data.admins

      )

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: AdminIndexController
    controllerAs: 'vm'
    bindToController: true
