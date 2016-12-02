angular.module 'bijyoZukanGroup'
.directive 'shopDetailDirective',  ->
  ShopDetailController = (shopService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'},{name:'Shop list',link:'/shop/shops'}]
      vm.active_tab = 'ja'
      vm.chartLineOptions = {
        padding:{top: 10,right: 10,bottom: 20,left: 10}
        showY:true
        showX:true
        legend:true
        tooltip:true
        height:'100px'
        chartColor:'#fff'
      }
      console.log($state)
      vm.getShop()
      vm.getDate()
      vm.getContacts()
    vm.getShop = ->
      shopService.getShop($state.params.id).then((res) ->
        console.log(res)
        vm.shop = res.data.shop
      )

    vm.getDate = ->
      shopService.getDate($state.params.id).then((res) ->
        vm.chartLine1 = res.data.chart_date
        vm.monthly_contact_count = res.data.monthly_contact_count
        vm.monthly_favorite_count = res.data.monthly_favorite_count
        vm.monthly_pv_count = res.data.monthly_pv_count
        vm.monthly_support_count = res.data.monthly_support_count
        vm.monthly_review_count = res.data.monthly_review_count
      )
    vm.getContacts = ->
      shopService.getContacts($state.params.id).then((res) ->
        vm.contacts = res.data.contacts
        vm.reviews = res.data.reviews
      )




    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: ShopDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
