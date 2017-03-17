angular.module 'bijyoZukanAdmin'
.directive 'eventIndexDirective',  ->
  EventIndexController = ($state, eventService,modalService) ->
    vm = this
    vm.init = ->
      vm.filter ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'contact',link:''}]
      vm.getEvents()
    vm.getEvents = ->
      eventService.events().then((res) ->
        vm.events = res.data.events
        vm.total = res.data.total
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: EventIndexController
    controllerAs: 'vm'
    bindToController: true
