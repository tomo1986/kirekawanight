angular.module 'bisyoujoZukanNight'
.directive 'comseptDirective', ($state,$rootScope) ->
  ComseptController = () ->
    vm = this
    vm.breadcrumb = [{name:'TOP',link:'/'},{name:'COMSEPT',link:''}]
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ComseptController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
