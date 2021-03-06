angular.module 'bisyoujoZukanNight'
.directive 'customerMypageBasicDirective', ($state,customerService,modalService , api,validationService) ->
  CustomerMypageBasicController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'MYPAGE',link:''}]
      $state.go '.show' if $state.current.default_url == 'base'
      vm.activeTab = $state.current.active_tab
      vm.canReviewSubmited = true
      vm.isReviewShopLoading = true
      vm.isReviewUserLoading = true
      vm.review_shops = []
      vm.review_users = []
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.birthday_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.shopReviweFilters = {
        id: vm.loginCustomer.id
        limit: 10
        page: if $state.params.page then $state.params.page else 1
      }
      vm.castReviweFilters = {
        id: vm.loginCustomer.id
        limit: 10
        page: if $state.params.page then $state.params.page else 1
      }

      vm.getFavorited()
      vm.getReviews()

    vm.getContcts = ->

    vm.getReviews = ->
      vm.isReviewShopLoading = true
      vm.isReviewUserLoading = true
      customerService.getReviews(vm.shopReviweFilters).then((res) ->
        if res.data.code == 1
          vm.review_shop_total = res.data.review_shop_total
          vm.review_user_total = res.data.review_user_total
          angular.forEach(res.data.review_shops, (review) ->
            vm.review_shops.push(review)
          )
          angular.forEach(res.data.review_users, (review) ->
            vm.review_users.push(review)
          )
        vm.isReviewShopLoading = false
        vm.isReviewUserLoading = false
      )
    vm.getShopReviews = ->
      vm.isReviewShopLoading = true
      customerService.getReviews(vm.shopReviweFilters).then((res) ->
        if res.data.code == 1
          angular.forEach(res.data.review_shops, (review) ->
            vm.review_shops.push(review)
          )
        vm.isReviewShopLoading = false
      )
    vm.getCastReviews = ->
      vm.isReviewUserLoading = true
      customerService.getReviews(vm.castReviweFilters).then((res) ->
        if res.data.code == 1
          angular.forEach(res.data.review_shops, (review) ->
            vm.review_shops.push(review)
          )
        vm.isReviewUserLoading = false
      )
    vm.onAddShopReviews = ->
      vm.shopReviweFilters.page++
      vm.getShopReviews()
    vm.onAddCastReviews = ->
      vm.castReviweFilters.page++
      vm.getCastReviews()




    vm.submit = ->
      vm.errors = null
      console.log(vm.loginCustomer)
      vm.errors = validationService.checks(vm.loginCustomer,customerService.getValidationRule())
      console.log(vm.errors)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      vm.canReviewSubmited = false
      title = "変更しました！！"
      buttons = [
        {name:'MYPAGEトップに戻る',link:"/mypage/show"}
        {name:"KireKawaトップに戻る",link:"/"}
      ]

      customerService.update(vm.loginCustomer).then((res) ->
        if res.data.code == 1
          vm.loginCustomer = res.data.customer
          datas = [
            {name:"name", val: vm.loginCustomer.name, kind:"string"}
            {name:"TEL", val: vm.loginCustomer.tel, kind:"string"}
            {name:"email", val: vm.loginCustomer.email, kind:"string"}
            {name:"birthday", val: vm.loginCustomer.birthday, kind:"date"}
            {name:"sns_line", val: vm.loginCustomer.sns_line, kind:"string"}
            {name:"sns_zalo", val: vm.loginCustomer.sns_zalo, kind:"string"}
            {name:"sns_wechat", val: vm.loginCustomer.sns_wechat, kind:"string"}
          ]
          modalService.confirm(title,datas,buttons)
        else
          modalService.error('エラー',res.data.message)
        vm.canReviewSubmited = true
      )



    vm.getFavorited = ->
      api.getPromise('/api/front/api11',{}).then((res) ->
        vm.karaokeUsers = res.data.favorite_karaoke_users
        vm.barUsers = res.data.favorite_bar_users
        vm.massageUsers = res.data.favorite_massage_users
        vm.sexyUsers = res.data.favorite_sexy_users
        vm.favorites = res.data.favorites
      )

    vm.onClickedFavorite = (opt_cast_id)->
      vm.favoriteCastId = opt_cast_id
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
        receiver_id: vm.favoriteCastId
        receiver_type: 'User'
      }
      castService.pushSupport(params).then((res) ->
        vm.favorites = res.data.favorites
        title = res.data.message
        modalService.alert(title)
        vm.getFavorited()
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      scope.vm.activeTab = toState.active_tab
    )
    return
  directive =
    restrict: 'A'
    controller: CustomerMypageBasicController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
