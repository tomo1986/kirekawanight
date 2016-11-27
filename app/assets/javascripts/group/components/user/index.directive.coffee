angular.module 'bijyoZukanGroup'
.directive 'userIndexDirective',  ->
  UserIndexController = ($state, user,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/group'},{name:'User list',link:''}]
      vm.users = []
      vm.filters ={
        keyword: null
        group_id: null
        job_type: null
        sex: null
        limit: 20
        page: if $state.params.page then $state.params.page else 1
        ordered: 'id'
      }
      vm.getUsers()

    vm.getUsers = ->
      user.getUsers(vm.filter).then((res) ->
          vm.users = res.data.users
          vm.groups = res.data.groups
          vm.total = res.data.total
          window.scrollTo(0, 0)
      )
    vm.submit = ->


    vm.executeDeletion = () ->
      mapService.deleteMap(vm.delete_map_id).then((res) ->
        if res.code == 1
          modalService.alert('削除しました。')
          vm.getMaps()
        else
          modalService.error(res.data.message)
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
