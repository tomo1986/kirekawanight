angular.module 'bijyoZukanAdmin'
.directive 'userIndexDirective',  ->
  UserIndexController = ($state, user,modalService,shopService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'User list',link:''}]
      vm.users = []
      vm.filters ={
        keyword: if $state.params.keyword then $state.params.keyword else null
        group_id: if $state.params.group_id then Number($state.params.group_id) else null
        shop_id: if $state.params.shop_id then Number($state.params.shop_id) else null
        job_type: if $state.params.job_type then $state.params.job_type else null
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        ordered: 'id'
      }
      vm.getUsers()
      vm.getShops()
      vm.getGroups()


    vm.getShops = ->
      shopService.allGetShops().then((res) ->
        if res.data.code == 1
          vm.shops = res.data.shops
      )
    vm.getGroups = ->
      shopService.getGroups().then((res) ->
        if res.data.code == 1
          vm.groups = res.data.groups
      )

    vm.getUsers = ->
      user.getUsers(vm.filters).then((res) ->
          vm.users = res.data.users
          vm.total = res.data.total
          window.scrollTo(0, 0)
      )

    vm.executeDeletion = (opt_id) ->
      user.deleteUser({id: opt_id}).then((res) ->
        if res.data.code == 1
          modalService.alert('完了しました')
          vm.getUsers()
        else
          modalService.error("error",res.data.message)
      )

    vm.submit = ->
      vm.filters.page = 1
      vm.changePageFunk()

    vm.onPageChanged = (page) ->
      vm.filters.page = page
      vm.changePageFunk()

    vm.changePageFunk = ->
      $state.go('/users',{page:vm.filters.page, sort: vm.filters.sort, order: vm.filters.order,keyword: vm.filters.keyword, group_id: vm.filters.group_id, shop_id: vm.filters.shop_id, job_type: vm.filters.job_type})


    vm.init()
    return
  directive =
    restrict: 'A'
    controller: UserIndexController
    controllerAs: 'vm'
    bindToController: true
