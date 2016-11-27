angular.module 'bijyoZukanGroup'
.directive 'pickupFormDirective',  ->
  PickupFormController = (pickupService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.subjectList = []
      vm.start_at_options={
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
        vm.getPickup()
      else
        vm.breadcrumb.push({name:'MAP新規作成',link:''})
        vm.newPickup()

    vm.getPickup = ->
      pickupService.getPickup($state.params.id).then((res) ->
        vm.pickup = res.data.pickup
        vm.getSubjects()
      )

    vm.newPickup = () ->
      pickupService.newPickup().then((res) ->
        vm.pickup = res.data.pickup
        vm.getSubjects()
      )

    vm.getSubjects = () ->
      pickupService.getSubjects().then((res) ->
        vm.users = res.data.users
        vm.groups = res.data.groups
        if vm.pickup.subject_type == 'Group'
          vm.subjectList = vm.groups
        else if vm.pickup.subject_type == 'User'
          vm.subjectList = vm.users
      )

    vm.submit = ->
      buttons = [
        {name:'一覧へ戻る',link:"/group/pickups"}
      ]
      if vm.action == 'update'
        pickupService.updatePickup(vm.pickup).then((res) ->
          vm.pickup = res.data.pickup
          modalService.confirm("hozonsiha")
        )
      else
        pickupService.createPickup(vm.pickup).then((res) ->
          vm.pickup = res.data.pickup
          modalService.confirm("hozonsiha")

        )


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->

    scope.$watch("vm.pickup.subject_type",(val) ->
      console.log("aaaa",val)
      if val == 'Group'
        scope.vm.subjectList = scope.vm.groups
      else if val == 'User'
        scope.vm.subjectList = scope.vm.users
    )

    return

  directive =
    restrict: 'A'
    controller: PickupFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
