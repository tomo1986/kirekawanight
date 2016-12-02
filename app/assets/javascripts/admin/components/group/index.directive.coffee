angular.module 'bijyoZukanAdmin'
.directive 'groupIndexDirective',  ->
  GroupIndexController = ($state, groupService,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Group List',link:''}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.getGroups()

    vm.getGroups = ->
      groupService.getGroups(vm.filter).then((res) ->
        vm.groups = res.data.groups
        window.scrollTo(0, 0)
      )

    vm.executeDeletion = (opt_id) ->
      groupService.deleteGroup({id: opt_id}).then((res) ->
        if res.data.code == 1
          modalService.alert('削除しました。')
          vm.getGroups()
        else
          modalService.error("error",res.data.message)
      )

    vm.pageChanged = (page) ->
      $state.go('/groups',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: GroupIndexController
    controllerAs: 'vm'
    bindToController: true
