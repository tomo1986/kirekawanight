angular.module 'bijyoZukanAdmin'
.directive 'homeDirective',  ->
  HomeController = (modalService, $scope, api) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'}]
      vm.download_capsule_count = null
      vm.capsule_count = null
      vm.map_view_count = null
      vm.log_actions = null
      vm.getDatas()

    vm.getDatas = () ->
      api.getPromise('/api/admin/api56',{}).then((res) ->
        if res.data.code == 1
          vm.reviews = res.data.reviews
          vm.shop_count = res.data.shop_count
          vm.user_count = res.data.user_count
        else

          modalService.error(res.data.message)
      )
    vm.onClickDisplayed = (review) ->
      api.postPromise('/api/admin/api57',review).then((res) ->
        if res.data.code == 1
          vm.reviews = res.data.reviews
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
