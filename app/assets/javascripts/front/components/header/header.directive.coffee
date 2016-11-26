angular.module 'bisyoujoZukanNight'
.directive 'headerDirective',  ->
  HeaderController = ($state,api) ->
    vm = this


    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
