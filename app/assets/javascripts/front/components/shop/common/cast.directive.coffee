angular.module 'bisyoujoZukanNight'
.directive 'shopDetailCastDirective', (shopService, $state) ->
  ShopDetailCastController = () ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.casts = []
      vm.newCasts = []

      vm.filters ={
        id: vm.parentCtrl.pageId
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
      }
      vm.getCasts()

    vm.getCasts = ->
      shopService.getCasts(vm.filters).then((res) ->
        if res.data.code == 1
          vm.total = res.data.total
          angular.forEach(res.data.users, (cast) ->
            vm.casts.push(cast)
          )
          angular.forEach(res.data.new_users, (cast) ->
            vm.newCasts.push(cast)
          )
          vm.isLoading = false
      )
    vm.getloadCasts = ->
      shopService.getCasts(vm.filters).then((res) ->
        if res.data.code == 1
          vm.total = res.data.total
          angular.forEach(res.data.users, (cast) ->
            vm.casts.push(cast)
          )
          vm.isLoading = false
      )

    vm.onAddCasts = ->
      vm.filters.page++
      vm.changePageFunk()

    vm.changePageFunk = ->
      vm.getloadCasts()

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
    controller: ShopDetailCastController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/shops/common/_cast.html"
    bindToController: true

