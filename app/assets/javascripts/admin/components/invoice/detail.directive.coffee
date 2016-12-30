angular.module 'bijyoZukanAdmin'
.directive 'invoiceDetailDirective',  ->
  InvoiceDetailController = (invoiceService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Invoice list',link:'/admin/invoices'}]

      vm.getInvoice()
    vm.getInvoice = ->
      invoiceService.getInvoice($state.params.id).then((res) ->
        vm.invoice = res.data.invoice
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: InvoiceDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
