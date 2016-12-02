angular.module 'bijyoZukanShop'
.directive 'userIndexDirective',  ->
  UserIndexController = ($state, user,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'},{name:'User list',link:''}]
      vm.users = []
      vm.filters ={
        keyword: null
        shop_id: null
        job_type: null
        sex: null
        limit: 20
        page: if $state.params.page then $state.params.page else 1
        ordered: 'id'
      }
      vm.getUsers()

    vm.getUsers = ->
      user.getUsers(vm.filter).then((res) ->
        if res.data.code == 1
          vm.users = res.data.users
          vm.shops = res.data.shops
          vm.total = res.data.total
          window.scrollTo(0, 0)
        else
          modalService.alert('Error',"Please retry")
      )
    vm.onCancelButtonClicked = (opt_user_id) ->
      user.deleteUser({id: opt_user_id}).then((res) ->
        if res.code == 1
          modalService.alert('削除しました。')
          vm.getUsers()
        else
          modalService.error("Error",res.data.message)
      )

    vm.pageChanged = (page) ->
      $state.go('/users',{page:page})
      return


    vm.init()
    return
  directive =
    restrict: 'A'
    controller: UserIndexController
    controllerAs: 'vm'
    bindToController: true
