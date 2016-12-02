angular.module 'bijyoZukanShop'
.directive 'homeDirective',  ->
  HomeController = (modalService, $scope, api, shopService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'}]
      vm.download_capsule_count = null
      vm.capsule_count = null
      vm.map_view_count = null
      vm.log_actions = null
      vm.getShop()
      vm.getDate()
      vm.getContacts()

    vm.getDate = ->
      shopService.getDate().then((res) ->
        vm.chartLine1 = res.data.chart_date
        vm.monthly_contact_count = res.data.monthly_contact_count
        vm.monthly_favorite_count = res.data.monthly_favorite_count
        vm.monthly_pv_count = res.data.monthly_pv_count
        vm.monthly_support_count = res.data.monthly_support_count
        vm.monthly_review_count = res.data.monthly_review_count
      )
    vm.getContacts = ->
      shopService.getContacts().then((res) ->
        vm.contacts = res.data.contacts
        vm.reviews = res.data.reviews
      )


    vm.getShop = ->
      shopService.getShop().then((res) ->
        vm.shop = res.data.shop
      )

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: HomeController
    controllerAs: 'vm'
    bindToController: true
