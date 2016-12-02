angular.module 'bijyoZukanAdmin'
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
      )

    vm.newPickup = () ->
      pickupService.newPickup().then((res) ->
        vm.pickup = res.data.pickup
      )

    vm.getAllUsers = () ->
      pickupService.getAllUsers().then((res) ->
        vm.users = res.data.users
        vm.subjectList = vm.users
      )
    vm.getAllShops = () ->
      pickupService.getAllShops().then((res) ->
        vm.shops = res.data.shops
        vm.subjectList = vm.shops
      )


    vm.submit = ->
      buttons = [
        {name:'一覧へ戻る',link:"/admin/pickups"}
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
    controller: PickupFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
