angular.module 'bijyoZukanAdmin'
.directive 'eventFormDirective',  ->
  EventFormController = (eventService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'}]
      vm.subjectList = []
      vm.started_at_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.end_at_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.active_tab = 'ja'
      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getEvent()
      else
        vm.breadcrumb.push({name:'MAP新規作成',link:''})
        vm.newEvent()

    vm.getEvent = ->
      eventService.getEvent($state.params.id).then((res) ->
        vm.event = res.data.event
      )

    vm.newEvent = () ->
      eventService.newEvent().then((res) ->
        vm.event = res.data.event
      )

    vm.getAllUsers = () ->
      eventService.getAllUsers().then((res) ->
        vm.users = res.data.users
        vm.subjectList = vm.users
      )
    vm.getAllShops = () ->
      eventService.getAllShops().then((res) ->
        vm.shops = res.data.shops
        vm.subjectList = vm.shops
      )


    vm.submit = ->
      buttons = [
        {name:'一覧へ戻る',link:"/admin/events"}
      ]
      if vm.action == 'update'
        eventService.updateEvent(vm.event).then((res) ->
          vm.event = res.data.event
          datas = vm.makeDataForModal(vm.event)
          modalService.confirm("保存しました。",datas,buttons)

        )
      else
        eventService.createEvent(vm.event).then((res) ->
          vm.event = res.data.event
          datas = vm.makeDataForModal(vm.event)
          modalService.confirm("保存しました。",datas,buttons)

        )

    vm.makeDataForModal = (event)->
      return [
        {name:"title", val: event.title, kind:"string"}
      ]

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.event.subject_type",(val) ->
      if val == 'Shop'
        return scope.vm.subjectList = scope.vm.shops if scope.vm.shops
        scope.vm.getAllShops()
      else if val == 'User'
        return scope.vm.subjectList = scope.vm.users if scope.vm.users
        scope.vm.getAllUsers()
    )

    return

  directive =
    restrict: 'A'
    controller: EventFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
