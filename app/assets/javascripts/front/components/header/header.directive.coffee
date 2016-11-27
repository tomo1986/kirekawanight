angular.module 'bisyoujoZukanNight'
.directive 'headerDirective',  ->
  HeaderController = ($state,api) ->
    vm = this
    api.getPromise('/api/front/api20',{}).then((res) ->
      vm.userCount = res.data.user_count
      vm.groupCount = res.data.group_count
    )


    return
  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
