angular.module 'bijyoZukanAdmin'
.directive 'invoiceIndexDirective',  ->
  InvoiceIndexController = ($state, modalService, $scope, api,invoiceService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.hasPrintIds = []
      vm.isSettingAll = false
      vm.getInvoices()

    vm.onclickPrint = (id) ->
      if vm.hasPrintIds.indexOf(id) == -1
        vm.hasPrintIds.push(id)
      else
        angular.forEach(vm.hasPrintIds,(value,i) ->
          vm.hasPrintIds.splice(i,1) if value == id
        )
    vm.onclickAllPrint = ->
      vm.isSettingAll = !vm.isSettingAll
      if vm.isSettingAll
        angular.forEach(vm.invoices,(value,i) ->
          vm.hasPrintIds.push(value.id)
        )
      else
        vm.hasPrintIds = []
      console.log(vm.hasPrintIds)

    vm.onclickSetPrintIds = () ->
      invoiceService.postPrintIds(vm.hasPrintIds)
      url = "/admin/invoices/prints?ids=#{vm.hasPrintIds}"
      window.open(url,'_blank')

    vm.getInvoices = () ->
      invoiceService.getInvoices(vm.filter).then((res) ->
        if res.data.code == 1
          vm.invoices = res.data.invoices
          vm.total = res.data.total
        else
          modalService.error(res.data.message)
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: InvoiceIndexController
    controllerAs: 'vm'
    bindToController: true
