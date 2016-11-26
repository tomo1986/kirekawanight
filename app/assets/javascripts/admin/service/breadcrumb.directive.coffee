angular.module 'bijyoZukanAdmin'
.directive 'breadcrumbDirective',  ->
  BreadcrumbController = () ->
    vm = this
    vm.list = vm.data
    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/block/breadcrumb.html"
    controller: BreadcrumbController
    controllerAs: 'vm'
    scope:{data: "="}
    bindToController: true
