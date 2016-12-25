angular.module 'bisyoujoZukanNight'
.directive 'castDetailCastDirective', (castService, $state) ->
  CastDetailCastController = () ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.casts = []
      vm.newCasts = []
      vm.filters ={
        id: $state.params.id
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
      }
      vm.getSomeShopCasts()

    vm.getSomeShopCasts = ->
      vm.isLoading = true
      castService.getSomeShopCasts(vm.filters).then((res) ->
        vm.total = res.data.total
        console.log(res.data.users)
        angular.forEach(res.data.users, (user) ->
          vm.casts.push(user)
        )
        vm.isLoading = false
      )

    vm.onAddCasts = ->
      vm.filters.page++
      vm.changePageFunk()

    vm.changePageFunk = ->
      vm.getSomeShopCasts()

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.filters.sort",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.casts = []
        scope.vm.isLoading = true
        scope.vm.filters.sort = newVal
        scope.vm.filters.page = 1
        scope.vm.changePageFunk()

    )
    scope.$watch("vm.filters.order",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.casts = []
        scope.vm.isLoading = true
        scope.vm.filters.order = newVal
        scope.vm.filters.page = 1
        scope.vm.changePageFunk()
    )

    return
  directive =
    restrict: 'E'
    scope:{
      parentCtrl: "="
    }
    controller: CastDetailCastController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/casts/common/_cast.html"
    bindToController: true

