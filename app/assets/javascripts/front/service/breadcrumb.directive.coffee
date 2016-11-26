angular.module 'bisyoujoZukanNight'
.directive 'breadcrumbDirective',  ->
  BreadcrumbController = () ->
    vm = this
    vm.list = vm.data
    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/breadcrumb.html"
    controller: BreadcrumbController
    controllerAs: 'vm'
    scope:{data: "="}
    bindToController: true
