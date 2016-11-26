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

    vm.executeDeletion = () ->
      mapService.deleteMap(vm.delete_map_id).then((res) ->
        if res.code == 1
          modalService.alert('削除しました。')
          vm.getMaps()
        else
          modalService.error(res.data.message)
      )

    vm.pageChanged = (page) ->
      $state.go('/maps',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: GroupIndexController
    controllerAs: 'vm'
    bindToController: true
