angular.module 'bisyoujoZukanNight'
.directive 'shopBarIndexDirective', ($state) ->
  ShopBarIndexController = (shopService, customerService, modalService) ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE GROUP',link:''}]
      vm.filters ={
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
        job_type: 'bar'
      }

      vm.getShops()

    vm.getShops = ->
      shopService.getShopList(vm.filters).then((res) ->
        vm.push_shops = res.data.push_shops
        vm.shops = res.data.shops
        vm.total = res.data.total
        vm.favorites = res.data.favorites
        vm.isLoading = false
      )

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
      $state.go('/shops/bar',{page:vm.filters.page, sort: vm.filters.sort, order: vm.filters.order})
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
    controller: ShopBarIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
