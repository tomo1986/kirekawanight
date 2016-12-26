angular.module 'bisyoujoZukanNight'
.directive 'makeDateDirective',  ->
  BreadcrumbController = () ->
    vm = this
    vm.date
    if vm.date
      vm.date = new Date()
    vm.list = vm.data
    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/breadcrumb.html"
    controller: BreadcrumbController
    controllerAs: 'vm'
    scope:{date: "="}
    bindToController: true
