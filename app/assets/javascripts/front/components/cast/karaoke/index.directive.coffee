angular.module 'bisyoujoZukanNight'
.directive 'castKaraokeIndexDirective', ($state) ->
  CastKaraokeIndexController = (castService, customerService, modalService) ->
    console.log("aaa")
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'TOP',link:'/'},{name:'KARAOKE CAST',link:''}]
      vm.filters ={
        limit: 20
        page: if $state.params.page then $state.params.page else 1
        sort: 'new'
        order: 'desc'
        job_type: 'karaoke'
      }
      console.log(vm.selectActive)
      vm.getCasts()

    vm.onPageChanged = (page) ->
      $state.go('/casts/karaoke',{page:page})

    vm.getCasts = ->
      castService.getCastList(vm.filters).then((res) ->
        vm.push_casts = res.data.push_users
        vm.casts = res.data.users
        vm.total = res.data.total
        vm.favorites = res.data.favorites
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
    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.filters.sort",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.getCasts()
    )
    scope.$watch("vm.filters.order",(newVal,oldVal) ->
      if newVal != oldVal
        scope.vm.getCasts()
    )

    return
  directive =
    restrict: 'A'
    controller: CastKaraokeIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
