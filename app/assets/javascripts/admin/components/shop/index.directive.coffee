angular.module 'bijyoZukanAdmin'
.directive 'shopIndexDirective',  ->
  ShopIndexController = ($state, shopService,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Shop List',link:''}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.getShops()

    vm.getShops = ->
      shopService.getShops(vm.filters).then((res) ->
        vm.shops = res.data.shops
        vm.total = res.data.total
        window.scrollTo(0, 0)
      )

    vm.executeDeletion = (opt_id) ->
      shopService.deleteShop({id: opt_id}).then((res) ->
        if res.data.code == 1
          modalService.alert('完了しました')
          vm.getShops()
        else
          modalService.error("error",res.data.message)
      )

    vm.onPageChanged = (page) ->
      $state.go('/shops',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: ShopIndexController
    controllerAs: 'vm'
    bindToController: true
