angular.module 'bijyoZukanAdmin'
.directive 'adminFormDirective',  ->
  AdminFormController = (api,modalService,$state,validationService) ->
    vm = this
    self = vm
    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'管理者一覧',link:'/admin/admins'}]
      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getAdmin()
      else
        vm.admin= {name:undefined,email:undefined,password:undefined}


    vm.getAdmin = ->
      api.getPromise('/api/admin/api71',{id:$state.params.id }).then((res) ->
        vm.admin = res.data.admin
      )
    vm.submit = ->
      buttons = [
        {name:'一覧へ戻る',link:"/admin/admins"}
      ]
      api.postPromise('/api/admin/api72',vm.admin).then((res) ->
        if res.data.code == 1
          vm.admin = res.data.admin
          title = "保存しました。"
          datas = vm.makeDataForModal(vm.admin)
          modalService.confirm(title,datas,buttons)
        else
          modalService.error(res.data.errors)


      )

    vm.makeDataForModal = (admin)->
      return [
        {name:"name", val: admin.name, kind:"string"}
        {name:"Email", val: admin.email, kind:"string"}
      ]


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.user.shop_id",(newVal,oldVal) ->
      if newVal != oldVal && oldVal != undefined
        angular.forEach(scope.vm.shops,(shop) ->
          scope.vm.user.job_type = shop.job_type if Number(newVal) == Number(shop.id)
        )
    )
    return

  directive =
    restrict: 'A'
    controller: AdminFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
