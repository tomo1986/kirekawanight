angular.module 'bijyoZukanAdmin'
.directive 'invoiceFormDirective',  ->
  InvoiceFormController = (invoiceService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Invoice',link:''}]
      vm.period_from_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'

      }
      vm.period_to_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.due_date_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.paid_at_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:false
        placeholder:'必須'
      }


      vm.loaded = false
      vm.options =
        allowedContent: true
        entities: false
      vm.getShops()
      vm.getAdmins()

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getInvoice()
      else
        vm.newInvoice()
        vm.breadcrumb.push({name:'New Invoice',link:''})

    vm.getAdmins = ->
      invoiceService.getAdmins().then((res) ->
        vm.admins = res.data
      )

    vm.getShops = ->
      invoiceService.allGetShops().then((res) ->
        vm.shops = res.data.shops
      )



    vm.getInvoice = ->
      invoiceService.getInvoice($state.params.id).then((res) ->
        vm.invoice = res.data.invoice

        detail = {name: null,invoice_id: $state.params.id,quantilty: null,unit_price: null,category: null}
        vm.invoice.invoice_details.push(detail)

      )
    vm.newInvoice = ->
      invoiceService.newInvoice().then((res) ->
        vm.invoice = res.data.invoice
      )

    vm.updateInvoiceDetail = (detail,index) ->
      vm.errors = new Array(vm.invoice.invoice_details.length)
      vm.errors[index] = validationService.checks(detail,invoiceService.getInvoiceDetailValidationRule())
      return if Object.keys(vm.errors[index]) && Object.keys(vm.errors[index]).length > 0

      invoiceService.updateInvoiceDetail(detail).then((res) ->
        console.log(res)
        if res.data.code == 1
          vm.invoice.invoice_details = res.data.invoice_details
          modalService.error("更新しました。")

        else
          modalService.error(res.data.errors)
      )

    vm.addInvoiceDetail = ->
      detail = {
        name: null
        invoice_id: $state.params.id
        quantilty: null
        unit_price: null
        category: null
      }
      vm.invoice.invoice_details.push(detail)

    vm.deleteInvoiceDetail = (detail)->
      if detail.id
        invoiceService.deleteInvoiceDetail(detail).then((res) ->
          if res.data.code == 1
            vm.invoice.invoice_details = res.data.invoice_details
            modalService.error("削除しました。")
          else
            modalService.error(res.data.errors)
        )
      else
        angular.forEach(vm.invoice.invoice_details,(value,i) ->
          vm.invoice.invoice_details.splice(i,1) if !value.id
        )

    vm.submit = ->
      vm.canSubmit = false
      title = "We saved finish "
      buttons = [
        {name:'一覧へ戻る',link:"/admin/invoices"}
        {name:'新しいカプセル追加',link:"/admin/invoices/new",callbackFunc: vm.init}
      ]
      params = {
        id: if $state.params && $state.params.id then $state.params.id else null
        admin_id: vm.invoice.admin_id
        shop_id: vm.invoice.shop_id
        due_date: vm.invoice.due_date
        paid_at: vm.invoice.paid_at
        issued_at: vm.invoice.issued_at
        period_from: vm.invoice.period_from
        period_to: vm.invoice.period_to
      }

      if vm.action == 'update'
        invoiceService.updateInvoice(params).then((res) ->
          if res.data.code == 1
            vm.canSubmit = true
            vm.invoice = res.data.invoice
            datas = vm.makeDataForModal(vm.invoice)
            console.log(title,datas,buttons)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        invoiceService.createInvoice(vm.invoice).then((res) ->
          if res.data.code == 1
            vm.invoice = res.data.invoice
            datas = vm.makeDataForModal(vm.invoice)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )


    vm.makeDataForModal = (invoice)->
      staffName = if invoice.staff then invoice.staff.name else null
      shopName = if invoice.shop then invoice.shop.name else null
      return [
        {name:"スタッフ名", val: staffName, kind:"string"}
        {name:"ショップ名", val: shopName, kind:"string"}
        {name:"請求金額", val:invoice.total, kind:"number"}
        {name:"請求期間(始まり)", val:invoice.period_from, kind:"date"}
        {name:"請求期間(終わり)", val:invoice.period_to, kind:"date"}
        {name:"期日", val:invoice.due_date, kind:"date"}
        {name:"請求書発行日", val:invoice.issued_at, kind:"date"}
        {name:"入金日", val:invoice.paid_at, kind:"date"}
        {name:"備考", val:invoice.note, kind:"text"}
      ]
    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
#    scope.$watch("vm.invoice.group_id",(newVal,oldVal) ->
#      if newVal != oldVal && oldVal != undefined
#        angular.forEach(scope.vm.groups,(group) ->
#          scope.vm.user.job_type = invoice.job_type if Number(newVal) == Number(invoice.id)
#        )
#    )

    return

  directive =
    restrict: 'A'
    controller: InvoiceFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
