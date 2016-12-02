angular.module 'bijyoZukanShop'
.directive 'discountFormDirective',  ->
  DiscountFormController = (api,discountService, shopService,modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.subjectList = []
      vm.start_at_options={
        from:{is_from:true,date:null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }
      vm.end_at_options={
        from:{is_from:true,date:null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }
      vm.active_tab = 'ja'
      vm.action = $state.current.action
      api.connect().then((res) ->
        vm.shop = res.shop
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
        vm.discount.tel = vm.shop.tel
        vm.discount.is_displayed = 1
      )

    vm.submit = ->
      title = "We saved finish "
      buttons = [
        {name:'return lists',link:"/shop/discounts"}
      ]
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

    scope.$watch("vm.discount.subject_type",(val) ->
      if val == 'Group'
        scope.vm.subjectList = scope.vm.shops
      else if val == 'User'
        scope.vm.subjectList = scope.vm.users
    )

    return

  directive =
    restrict: 'A'
    controller: DiscountFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
