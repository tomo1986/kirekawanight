angular.module 'bijyoZukanGroup'
.directive 'discountFormDirective',  ->
  DiscountFormController = (api,discountService, groupService,modalService,datePickerService,$state,validationService, shopService) ->
    vm = this
    self = vm

    vm.init = ->
      shopService.getShops({}).then((res) ->
       if res.data.code == 1
         vm.shops = res.data.shops
      )
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.subjectList = []
      vm.start_at_options={
        from:{is_from:true,date: null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }
      vm.end_at_options={
        to:{is_from:true,date:null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }
      vm.active_tab = 'ja'
      vm.action = $state.current.action
      api.connect().then((res) ->
        vm.group = res.group
        if vm.action == 'update'
          vm.getDiscount()
        else
          vm.breadcrumb.push({name:'MAP新規作成',link:''})
          vm.newDiscount()
      )


    vm.getDiscount = ->
      discountService.getDiscount($state.params.id).then((res) ->
        vm.discount = res.data.discount
      )

    vm.newDiscount = () ->
      discountService.newDiscount().then((res) ->
        vm.discount = res.data.discount
        vm.discount.is_displayed = 1
      )

    vm.submit = ->
      title = "We saved finish "
      buttons = [
        {name:'return lists',link:"/group/discounts"}
      ]
      console.log("submit",vm.discount)
      if vm.action == 'update'
        discountService.updateDiscount(vm.discount).then((res) ->
          vm.discount = res.data.discount
          datas = vm.makeDataForModal(vm.discount)
          modalService.confirm(title,datas,buttons)
        )
      else
        discountService.createDiscount(vm.discount).then((res) ->
          vm.discount = res.data.discount
          datas = vm.makeDataForModal(vm.discount)
          modalService.confirm(title,datas,buttons)

        )
    vm.makeDataForModal = (discount)->
      return [
        {name:"content", val: discount.content, kind:"text"}

      ]


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.discount.subject_id",(newVal,oldVal) ->
      if newVal != oldVal && oldVal != undefined
        angular.forEach(scope.vm.shops,(shop) ->
          scope.vm.discount.tel = shop.tel if Number(newVal) == Number(shop.id)
        )
    )
    scope.$watch("vm.discount.start_at",(newVal,oldVal) ->
      if newVal != oldVal && newVal != undefined
        scope.vm.end_at_options.to.date = newVal
    )
    scope.$watch("vm.discount.end_at",(newVal,oldVal) ->
      if newVal != oldVal && newVal != undefined
        scope.vm.start_at_options.from.date = newVal
    )


    return

  directive =
    restrict: 'A'
    controller: DiscountFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
