angular.module 'bisyoujoZukanNight'
.directive 'shopKaraokeIndexDirective', ($state) ->
  ShopKaraokeIndexController = (shopService, customerService, modalService,api) ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.displayedPoint = false
      vm.displayedDetail = false
      vm.displayedSort = true
      vm.points = {}
      vm.budget = null
      if $state.params.tags && typeof $state.params.tags != "string"
        angular.forEach($state.params.tags, (value) ->
          console.log(value)
          vm.points["tags#{value}"] = Number(value)
        )
      else
        vm.points["tags#{Number($state.params.tags)}"] = Number($state.params.tags)

      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE',link:''}]
      vm.filters ={
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
        job_type: 'karaoke'
        tags:if $state.params.tags then $state.params.tags else []
        budget:if $state.params.budget then $state.params.budget else null
        mama_tip:if $state.params.mama_tip then $state.params.mama_tip else null
        tip:if $state.params.tip then $state.params.tip else null
        charge:if $state.params.charge then $state.params.charge else null
        karaoke_machine:if $state.params.karaoke_machine then $state.params.karaoke_machine else null
        japanese:if $state.params.japanese then true else null
        english:if $state.params.english then true else null
        visa:if $state.params.visa then true else null
        master:if $state.params.master then true else null
        jcb:if $state.params.jcb then true else null
      }

      vm.getShops()
      vm.tags()
    vm.onClickDisplayedPoint = ->
      vm.displayedPoint = !vm.displayedPoint

    vm.onClickDisplayedDetail = ->
      vm.displayedDetail = !vm.displayedDetail

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
        vm.filters.tags.push(Number(value)) if value > 0
      )
      console.log(vm.points)
    vm.submitTags = ->
      vm.filters.page = 1
      vm.changePageFunk()

    vm.submitDetails = ->
      vm.filters.page = 1
      vm.filters.mama_tip = null if vm.filters.mama_tip == false
      vm.filters.tip = null if vm.filters.tip == false
      vm.filters.charge = null if vm.filters.charge == false
      vm.filters.karaoke_machine = null if vm.filters.karaoke_machine == false
      vm.filters.japanese = null if vm.filters.japanese == false
      vm.filters.english = null if vm.filters.english == false
      vm.filters.visa = null if vm.filters.visa == false
      vm.filters.master = null if vm.filters.master == false
      vm.filters.jcb = null if vm.filters.jcb == false


      vm.changePageFunk()

    vm.getShops = ->
      api.postPromise('/api/front/api12',vm.filters).then((res) ->
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
      console.log(vm.filters)
      $state.go('/shops/karaoke',{
        page:vm.filters.page
        sort: vm.filters.sort
        order: vm.filters.order
        tags: vm.filters.tags
        budget:vm.filters.budget
        mama_tip:vm.filters.mama_tip
        tip:vm.filters.tip
        charge:vm.filters.charge
        karaoke_machine:vm.filters.karaoke_machine
        japanese:vm.filters.japanese
        english:vm.filters.english
        jcb:vm.filters.jcb
        master:vm.filters.master
        visa:vm.filters.visa
      })



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
