angular.module 'bisyoujoZukanNight'
.directive 'systemDirective', ($state,$rootScope) ->
  SystemController = () ->
    vm = this
    vm.breadcrumb = [{name:'TOP',link:'/'},{name:'SYSTEM',link:''}]
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: SystemController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
