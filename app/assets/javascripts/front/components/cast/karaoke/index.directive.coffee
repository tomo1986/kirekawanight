angular.module 'bisyoujoZukanNight'
.directive 'castKaraokeIndexDirective', ($state) ->
  CastKaraokeIndexController = (castService, customerService, modalService, api) ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.displayedSort = false
      vm.displayedPoint = false
      vm.points = {}
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE CAST',link:''}]
      angular.forEach($state.params.tags, (value) ->
        vm.points["tags#{value}"] = Number(value)
      )

      vm.filters ={
        limit: 1
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
        job_type: 'karaoke'
        tags:if $state.params.tags then $state.params.tags else []
        bust:if $state.params.bust then $state.params.bust else null

      }
      vm.getCasts()
      vm.tags()
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
      $state.go('/casts/karaoke',{
        page:vm.filters.page
        sort: vm.filters.sort
        order: vm.filters.order
        tags: vm.filters.tags
        bust: vm.filters.bust

      })

    vm.changeFilterSort = (sort) ->
      vm.casts = null
      vm.isLoading = true
      vm.filters.sort = sort
      vm.filters.page = 1
      vm.changePageFunk()
    vm.onClickDisplayedPoint = ->  vm.displayedPoint = !vm.displayedPoint

    vm.tags = ->
      api.getPromise('/api/front/user_tags',{}).then((res) ->
        vm.tags = res.data.tags
      )
    vm.onSelectTag = (tag_id) ->
      flag = false
      vm.filters.tags = []
      console.log(tag_id)
      angular.forEach(vm.points, (value, key) ->
        if Number(value) == Number(tag_id)
          flag = true
          delete vm.points[key]
      )
      vm.points["tags#{tag_id}"] = Number(tag_id) if !flag
      angular.forEach(vm.points, (value, key) ->
        vm.filters.tags.push(Number(value))
      )
      console.log(vm.filters.tags)

    vm.submitTags = ->
      vm.filters.page = 1
      vm.changePageFunk()


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
    vm.onClickDisplayedSort = -> vm.displayedSort = !vm.displayedSort

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
