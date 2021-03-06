angular.module 'bisyoujoZukanNight'
.directive 'shopDetailDirective', ($state,$sce,shopService, modalService,customerService, NgMap, validationService) ->
  ShopDetailController = () ->
    vm = this
    vm.init = ->
      $state.go '.info' if $state.current.default_url == 'base'
      vm.breadcrumb = [{name:'キレカワ',link:'/'}]
      vm.makeBreadCrumb()
      vm.page = 1
      vm.isDisplayed_pickup_user = false
      vm.pageId = $state.params.id
      vm.selectCasts = []
      vm.isAttention = false
      vm.activeTab = $state.current.active_tab
      vm.displayContent = 'intoroduction'
      vm.active_language = 'ja'
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.getShop()

    vm.changeContents = (opt_content) ->
      vm.displayContent = opt_content

    NgMap.getMap().then((map) ->
      vm.ngMap = map
    )

    vm.makeBreadCrumb = ->
      if $state.current.active_menu == 'karaoke'
        vm.breadcrumb.push({name:'KARAOKE',link:'/shops/karaoke'})
      else if $state.current.active_menu == 'bar'
        vm.breadcrumb.push({name:'BAR',link:'/shops/bar'})
      else if $state.current.active_menu == 'massage'
        vm.breadcrumb.push({name:'MASSAGE',link:'/shops/massage'})


    vm.getShop = ->
      shopService.getShop($state.params.id).then((res) ->
        if res.data.code == 1
          vm.shop = res.data.shop
          vm.isFavorited = res.data.is_favorited
          vm.breadcrumb.push({name:vm.shop.name, link:''})
          vm.favorites = res.data.favorites
          vm.discounts  = res.data.discounts
          vm.shops = res.data.shops
          vm.pickup_users = res.data.pickup_users
          vm.isDisplayed_pickup_user = true
          vm.all_shop_count = res.data.all_shop_count
          vm.shopMainImg = vm.shop.images[0].url if vm.shop.images && vm.shop.images.length > 0
          vm.reviewQuestion = shopService.setReaviewQuestion(vm.shop.job_type)
          vm.shop.interview_ja = $sce.trustAsHtml(vm.shop.interview_ja)
          vm.test = "https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FKireKawa-231672127266670%2F&tabs=timeline&width=340&height=500&small_header=true&adapt_container_width=true&hide_cover=false&show_facepile=false&appId"
          vm.shop.youtube.script = $sce.trustAsHtml(vm.shop.youtube.script) if vm.shop.youtube
          vm.shop.twitter.script = $sce.trustAsHtml(vm.shop.twitter.script) if vm.shop.twitter
          vm.shop.facebook.script = $sce.trustAsHtml(vm.shop.facebook.script) if vm.shop.facebook
          vm.events = res.data.events
          vm.instagrams = res.data.instagrams


        else
          modalService.error('エラー',res.data.message)
      )

    vm.onClickedSupport = ->
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpSupport()
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.setLoginCustomer = (loginUser) ->
      customerService.setLoginCustomer(loginUser)
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.CountUpSupport()

    vm.CountUpSupport = (loginUser)->
      params = {
        type: 'support'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer.id
        receiver_id: $state.params.id
        receiver_type: 'Shop'
      }
      shopService.pushPost(params).then((res) ->
        title = res.data.title
        message = res.data.message
        vm.isFavorited = res.data.is_favorited
        modalService.alert(title,message)
      )
    vm.onClickedFavorite = ->
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpFavorite()
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.CountUpFavorite = ->
      params = {
        type: 'favorite'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer.id
        receiver_id: $state.params.id
        receiver_type: 'Shop'
      }
      shopService.pushPost(params).then((res) ->
        vm.favorites = res.data.favorites
        title = res.data.message
        message = res.data.message
        vm.isFavorited = res.data.is_favorited
        modalService.alert(title,message)
      )

    vm.onClickedImage = (opt_no) ->
      vm.shopMainImg = vm.shop.images[opt_no].url


    vm.onAttention = ->
      vm.isAttention = !vm.isAttention

    vm.carouselInitializer = ->
      $('#shopImage').slick
        dots: true
        accessibility: true
        infinite: true

        autoplay: true,
        autoplaySpeed: 4000
        slidesToShow: 1
        slidesToScroll: 1
        arrows: false
    vm.instaCarouselInitializer = ->
      $('#insta').slick
        dots: true
        accessibility: true
        infinite: true
        autoplay: true,
        autoplaySpeed: 4000
        slidesToShow: 4
        slidesToScroll: 4
        arrows: false
    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      scope.vm.activeTab = toState.active_tab
    )
    return
  directive =
    restrict: 'A'
    controller: ShopDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
