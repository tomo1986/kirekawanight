angular.module 'bisyoujoZukanNight'
.directive 'headerDirective',  (api) ->
  HeaderController = ($state) ->
    vm = this
    api.getPromise('/api/front/api20',{}).then((res) ->
      vm.userCount = res.data.user_count
      vm.groupCount = res.data.group_count
    )


    return
  linkFunc = (scope, el, attr, vm) ->
    console.log("=========",scope, el, attr, vm)
    scope.vm.userCount = vm.userCount
    scope.vm.groupCount = vm.groupCount
    return

  directive =
    restrict: 'E'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/header.html"
    controller: HeaderController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
