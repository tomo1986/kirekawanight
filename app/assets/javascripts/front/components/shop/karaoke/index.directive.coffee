angular.module 'bisyoujoZukanNight'
.directive 'shopKaraokeIndexDirective', ($state) ->
  ShopKaraokeIndexController = (shopService, customerService, modalService,api) ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.displayedPoint = false
      vm.displayedSort = true
      vm.points = {}
      angular.forEach($state.params.tags, (value) ->
        vm.points["tags#{value}"] = Number(value)
      )
      console.log($state.params.tags)

      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE GROUP',link:''}]
      vm.filters ={
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
        job_type: 'karaoke'
        tags:if $state.params.tags then $state.params.tags else []
        conditions: null
      }

      vm.getShops()
      vm.tags()
    vm.onClickDisplayedPoint = ->
      vm.displayedPoint = !vm.displayedPoint
    vm.onClickDisplayedSort = ->
      vm.displayedSort = !vm.displayedSort




    vm.tags = ->
      shopService.getTags().then((res) ->
        vm.tags = res.data.tags
      )
    vm.onSelectTag = (tag_id) ->
      flag = false
      vm.filters.tags = []
      angular.forEach(vm.points, (value, key) ->
        if Number(value) == Number(tag_id)
          flag = true
          delete vm.points[key]
      )
      vm.points["tags#{tag_id}"] = Number(tag_id) if !flag
      angular.forEach(vm.points, (value, key) ->
        vm.filters.tags.push(Number(value))
      )
      console.log(vm.points)
    vm.submitTags = ->
      vm.filters.page = 1
      vm.changePageFunk()

    vm.getShops = ->
      api.postPromise('/api/front/api12',vm.filters).then((res) ->
        vm.push_shops = res.data.push_shops
        vm.shops = res.data.shops
        vm.total = res.data.total
        vm.favorites = res.data.favorites
        vm.isLoading = false
      )


#      shopService.getShopList(vm.filters).then((res) ->
#          vm.push_shops = res.data.push_shops
#          vm.shops = res.data.shops
#          vm.total = res.data.total
#          vm.favorites = res.data.favorites
#          vm.isLoading = false
#        )

      vm.onClickedFavorite = (opt_cast_id)->
        vm.favoriteShopId = opt_cast_id
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
        receiver_id: vm.favoriteShopId
        receiver_type: 'Shop'
      }
      shopService.pushPost(params).then((res) ->
        vm.favorites = res.data.favorites
        angular.forEach(vm.shops, (shop) ->
          shop.favorite_count = res.data.favorite_count if shop.id == vm.favoriteShopId
        )

        title = res.data.message
        modalService.alert(title)
      )
    vm.onPageChanged = (page) ->
      vm.filters.page = page
      vm.changePageFunk()

    vm.changePageFunk = ->
      console.log(vm.filters)
      $state.go('/shops/karaoke',{page:vm.filters.page, sort: vm.filters.sort, order: vm.filters.order,tags: vm.filters.tags})



    vm.changeFilterSort = (sort) ->
      vm.casts = null
      vm.isLoading = true
      vm.filters.sort = sort
      vm.filters.page = 1
      vm.changePageFunk()

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ShopKaraokeIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
