angular.module 'bijyoZukanGroup'
.directive 'homeDirective',  ->
  HomeController = (modalService, $scope, api) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/group'}]
      vm.download_capsule_count = null
      vm.capsule_count = null
      vm.map_view_count = null
      vm.log_actions = null
      vm.getCount()

    vm.getCount = () ->
      api.getPromise('/api/group_page/api21',{}).then((res) ->
        if res.data.code == 1
          vm.capsule_count = res.data.data.capsule_count
          vm.map_view_count = res.data.data.group_view_count
          vm.download_capsule_count = res.data.data.download_count
          vm.log_actions = res.data.data.log_action
        else
          modalService.error(res.data.message)
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: HomeController
    controllerAs: 'vm'
    bindToController: true
