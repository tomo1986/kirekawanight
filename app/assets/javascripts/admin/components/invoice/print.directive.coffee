angular.module 'bijyoZukanAdmin'
.directive 'invoicePrintDirective',  ->
  InvoicePrintController = ($state, modalService, $scope, api, invoiceService) ->
    vm = this
    vm.init = ->
      ids = $state.params.ids
      vm.today = new Date()
      api.getPromise('/api/admin/api65',{ids: ids}).then((res) ->
        vm.invoices = res.data.invoices
        console.log("soeya",vm.invoices)
      )


    vm.init()
    return
  directive =
    restrict: 'A'
    controller: InvoicePrintController
    controllerAs: 'vm'
    bindToController: true
