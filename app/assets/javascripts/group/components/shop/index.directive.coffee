angular.module 'bijyoZukanGroup'
.directive 'shopIndexDirective',  ->
  ShopIndexController = ($state, shopService,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'},{name:'Shop List',link:''}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.getShops()

    vm.getShops = ->
      shopService.getShops(vm.filter).then((res) ->
        if res.data.code == 1
          vm.shops = res.data.shops
          window.scrollTo(0, 0)
        else
          modalService.alert("エラーが発生しました。","再度お試しください。")
      )

    vm.executeDeletion = (opt_id) ->
      shopService.deleteShop({id: opt_id}).then((res) ->
        if res.data.code == 1
          modalService.alert('削除しました。','復活したい場合は行ってください')
          vm.getShops()
        else
          modalService.error('エラーが発生しました。',"再度お試しください。")
      )

    vm.pageChanged = (page) ->
      $state.go('/shops',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: ShopIndexController
    controllerAs: 'vm'
    bindToController: true
