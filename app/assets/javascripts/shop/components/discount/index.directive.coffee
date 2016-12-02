angular.module 'bijyoZukanShop'
.directive 'discountIndexDirective',  ->
  DiscountIndexController = ($state, discountService,modalService) ->
    vm = this
    vm.init = ->
      vm.filter ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'contact',link:''}]
      vm.getDiscounts()
    vm.getDiscounts = ->
      discountService.discounts().then((res) ->
        vm.discounts = res.data.discounts
        vm.total = res.data.total
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: DiscountIndexController
    controllerAs: 'vm'
    bindToController: true
