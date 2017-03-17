angular.module 'bisyoujoZukanNight'
.directive 'eventDetailDirective',  () ->
  EventDetailController = ($state,api,$timeout, modalService) ->
    vm = this
    vm.init = ->
      api.getPromise('/api/front/api35',{id: $state.params.id}).then((res) ->
        if res.data.code == 1
          vm.event = res.data.event
          vm.events = res.data.events
        else
          modalService.error(res.data.errors)
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: EventDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
