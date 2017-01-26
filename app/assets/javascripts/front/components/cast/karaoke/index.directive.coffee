angular.module 'bisyoujoZukanNight'
.directive 'castKaraokeIndexDirective', ($state) ->
  CastKaraokeIndexController = (castService, customerService, modalService) ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE CAST',link:''}]

      vm.filters ={
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
        job_type: 'karaoke'
      }
      vm.getCasts()
    vm.getCasts = ->
      castService.getCastList(vm.filters).then((res) ->
        vm.push_casts = res.data.push_users
        vm.casts = res.data.users
        vm.total = res.data.total
        vm.favorites = res.data.favorites
        vm.isLoading = false
      )

    vm.onClickedFavorite = (opt_cast_id)->
      vm.favoriteCastId = opt_cast_id
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpFavorite()
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.setLoginCustomer = (loginUser) ->
      customerService.setLoginCustomer(loginUser)
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.CountUpFavorite()


    vm.CountUpFavorite = ->
      params = {
        type: 'favorite'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer.id
        receiver_id: vm.favoriteCastId
        receiver_type: 'User'
      }
      castService.pushSupport(params).then((res) ->
        vm.favorites = res.data.favorites
        title = res.data.message
        modalService.alert(title)
      )
    vm.onPageChanged = (page) ->
      vm.filters.page = page
      vm.changePageFunk()

    vm.changePageFunk = ->
      $state.go('/casts/karaoke',{page:vm.filters.page, sort: vm.filters.sort, order: vm.filters.order})

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.filters.sort",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.casts = null
        scope.vm.isLoading = true
        scope.vm.filters.sort = newVal
        scope.vm.filters.page = 1
        scope.vm.changePageFunk()

    )
    scope.$watch("vm.filters.order",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.casts = null
        scope.vm.isLoading = true
        scope.vm.filters.order = newVal
        scope.vm.filters.page = 1
        scope.vm.changePageFunk()
    )

    return
  directive =
    restrict: 'A'
    controller: CastKaraokeIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
