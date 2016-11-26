angular.module 'bisyoujoZukanNight'
.directive 'footerDirective',  ->
  FooterController = ($state,api) ->
    vm = this


    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/footer.html"
    controller: FooterController
    controllerAs: 'vm'
    bindToController: true
