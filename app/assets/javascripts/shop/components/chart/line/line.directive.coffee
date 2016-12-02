angular.module 'bijyoZukanShop'
.directive 'chartLineDirective', () ->
  ChartLineController = ($timeout) ->
    'ngInject'
    vm = this
    vm.options
    vm.date
    vm.id
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watchCollection('vm.date', (date) ->
      if(date != undefined)
        chart = c3.generate(
          bindto:"#" + scope.vm.id
          data: {
            x: 'x'
            columns:date

          }
          axis: x: {
            type: 'timeseries',
            tick: {
              format: '%Y-%m-%d'
            }
          }
        )
    )
    return
  directive =
    restrict: 'E'
    replace: true
    scope: {
      options:'='
      date: '='
      id: '@'
    }
    templateUrl: "#{location.protocol + '//' + location.host}/shop/tpl/chart/line.html"
    controller: ChartLineController
    controllerAs: 'vm'
    link: linkFunc
    bindToController: true
