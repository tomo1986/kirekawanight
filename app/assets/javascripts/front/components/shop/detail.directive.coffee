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
          vm.shopMainImg = vm.shop.images[0].url
          vm.reviewQuestion = shopService.setReaviewQuestion(vm.shop.job_type)
          vm.shop.interview_ja = $sce.trustAsHtml(vm.shop.interview_ja)
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
      $('.slick-slider').slick
        dots: true
        accessibility: true
        infinite: true
        autoplay: true,
        autoplaySpeed: 4000
        slidesToShow: 2
        slidesToScroll: 2
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 768,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 568,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 414,
            settings:{
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
        ]
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
