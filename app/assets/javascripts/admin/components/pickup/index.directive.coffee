angular.module 'bijyoZukanAdmin'
.directive 'pickupIndexDirective',  ->
  PickupIndexController = ($state, pickupService,modalService) ->
    vm = this
    vm.init = ->
      vm.filter ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'contact',link:''}]
      vm.getPickups()
    vm.getPickups = ->
      pickupService.pickups().then((res) ->
        vm.pickups = res.data.pickups
        vm.total = res.data.total
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: PickupIndexController
    controllerAs: 'vm'
    bindToController: true
