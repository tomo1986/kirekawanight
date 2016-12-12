angular.module 'bisyoujoZukanNight'
.directive 'shopDetailDirective', ($state,shopService, modalService,customerService, NgMap, validationService) ->
  ShopDetailController = () ->
    vm = this
    vm.init = ->
      $state.go '.info' if $state.current.default_url == 'base'
      vm.breadcrumb = [{name:'キレカワ',link:'/'}]
      vm.makeBreadCrumb()
      vm.page = 1
      vm.reviews = []
      vm.isAttention = false
      vm.activeTab = $state.current.active_tab

      vm.displayContent = 'intoroduction'
      vm.selectSns = 'Zalo'
      vm.active_language = 'ja'
      vm.serviceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.servingScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.girlScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.ambienceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.againScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}

      vm.loginCustomer = customerService.getLoginCustomer()
      vm.canContactSubmited = true
      vm.canReviewSubmited = true
      vm.reservationDate={
        from:{is_from:true,date:null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }

      vm.contactData = {
        contact_type: 'reservation'
        peoples: null
        selectCasts:[{image:null,title: "選択してください",isOpened:false}]
        reservation_date: null
      }


      vm.contact = {
        type: 'shop_detail'
        subject_type: 'Shop'
        subject_id: $state.params.id
        return_way: 'email'
        name: if vm.loginCustomer then vm.loginCustomer.name else null
        email: if vm.loginCustomer then vm.loginCustomer.email else null
        tel: if vm.loginCustomer then vm.loginCustomer.tel else null
        sns_zalo: if vm.loginCustomer then vm.loginCustomer.sns_zalo else null
        sns_wechat: if vm.loginCustomer then vm.loginCustomer.sns_wechat else null
        sns_line: if vm.loginCustomer then vm.loginCustomer.sns_line else null
        message: 'そのほか'
      }
      vm.review = {
        type: 'shop'
        sender_type: 'Customer'
        sender_id: if vm.loginCustomer then vm.loginCustomer.id else null
        receiver_type: 'Shop'
        receiver_id: $state.params.id
        service_score: 1
        serving_score: 1
        girl_score: 1
        ambience_score: 1
        again_score: 1
        comment: null
      }

      vm.getShop()
      vm.getReviews()
      vm.getCasts()

    vm.changeContents = (opt_content) ->
      vm.displayContent = opt_content

    NgMap.getMap().then((map) ->
      vm.ngMap = map
    )

    vm.getCasts = ->
      shopService.getCasts($state.params.id).then((res) ->
        if res.data.code == 1
          vm.casts = res.data.users
      )
    vm.getReviews = ->
      vm.isLoading = true
      params = {
        id: $state.params.id
        page: vm.page++
      }
      shopService.getReviews(params).then((res) ->
        vm.total = res.data.total
        angular.forEach(res.data.reviews, (review) ->
          vm.reviews.push(review)
        )

        vm.isLoading = false
      )

    vm.makeBreadCrumb = ->
      if $state.current.active_menu == 'karaoke'
        vm.breadcrumb.push({name:'KARAOKE SHOP',link:'/shops/karaoke'})
      else if $state.current.active_menu == 'bar'
        vm.breadcrumb.push({name:'BAR SHOP',link:'/shops/bar'})
      else if $state.current.active_menu == 'massage'
        vm.breadcrumb.push({name:'MASSAGE SHOP',link:'/shops/massage'})


    vm.getShop = ->
      shopService.getShop($state.params.id).then((res) ->
        if res.data.code == 1
          vm.shop = res.data.shop
          vm.isFavorited = res.data.is_favorited
          vm.breadcrumb.push({name:vm.shop.name, link:''})
          vm.newCasts = res.data.new_users
          vm.favorites = res.data.favorites
          vm.discounts  = res.data.discounts
          vm.shops = res.data.shops
          vm.shopMainImg = vm.shop.images[0].url
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

    vm.contactSubmit = ->
      vm.contactErrors = {}
      vm.contactErrors['name'] = '氏名を入力してくだい。' if !vm.contact.name
      if vm.contact.return_way == 'email'
        vm.contactErrors['email'] = 'emailを入力してくだい。' if !vm.contact.email
      else if vm.contact.return_way == 'sns'
        vm.contactErrors['sns'] = 'LINEアカウントを入力してくだい。' if !vm.contact.sns_line
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0

      message = ''
      message = message + "Customer Name： #{vm.contact.name}\n"
      message = message + "Return way： #{vm.contact.return_way}\n"
      message = message + "Email： #{vm.contact.email}\n"
      message = message + "LINE #{vm.contact.sns_line}\n"
      if vm.contactData.contact_type == 'reservation'
        message = message + "number of reservable：　#{vm.contactData.peoples}peaples\n"
        message = message + "reservation time：　#{vm.contactData.reservation_date}\n"
        message = message + "reservation casts\n"
        angular.forEach(vm.contactData.selectCasts, (cast) ->
          message = message + "#{cast.title}\n"
        )
        message = message + "\n\n"
      vm.contact.message = message + vm.contact.message
      vm.canContactSubmited = false

      shopService.sendContact(vm.contact).then((res) ->
        vm.canContactSubmited = true
        title = '受け付けました。'
        message = '回答を授時行っております。今しばらくお待ちください。'
        modalService.alert(title,message)
        vm.contact = {
          type: 'shop_detail'
          subject_type: 'Shop'
          subject_id: $state.params.id
          return_way: 'email'
          name: if vm.loginCustomer then vm.loginCustomer.name else null
          email: if vm.loginCustomer then vm.loginCustomer.email else null
          tel: if vm.loginCustomer then vm.loginCustomer.tel else null
          sns_zalo: if vm.loginCustomer then vm.loginCustomer.sns_zalo else null
          sns_wechat: if vm.loginCustomer then vm.loginCustomer.sns_wechat else null
          sns_line: if vm.loginCustomer then vm.loginCustomer.sns_line else null
          message: 'そのほか'
        }
      )

    vm.reviewSubmit = ->
      vm.reviewErrors = null
      vm.reviewErrors = validationService.checks(vm.review, shopService.reviewValidations)
      console.log(vm.reviewErrors)
      return if Object.keys(vm.reviewErrors) && Object.keys(vm.reviewErrors).length > 0

      vm.canReviewSubmited = false
      shopService.sendReview(vm.review).then((res) ->
        vm.canReviewSubmited = true
        title = '受け付けました。'
        message = '貴重なreviewありがとうございました改善に努めていきます。'
        modalService.alert(title,message)
        vm.review = {
          type: 'shop'
          sender_type: 'Customer'
          sender_id: vm.loginCustomer.id
          receiver_type: 'Shop'
          receiver_id: $state.params.id
          service_score: 1
          serving_score: 1
          girl_score: 1
          ambience_score: 1
          again_score: 1
          comment: null
        }
      )
    vm.onAttention = ->
      vm.isAttention = !vm.isAttention

    vm.onSelectCast = (cast) ->
      url = if cast.images[0] then cast.images[0].url else null
      vm.contactData.selectCasts[vm.selectDropDownNo] = {
        image:url,title:"Cast.No#{cast.id}/#{cast.name}",isOpened: false
      }

    vm.onClickDropDown = (cast, index) ->
      vm.selectDropDownNo = index
      vm.contactData.selectCasts[vm.selectDropDownNo].isOpened = !cast.isOpened

    vm.onAdd = ->
      vm.contactData.selectCasts[vm.selectDropDownNo].isOpened = false
      vm.selectDropDownNo = null
      vm.contactData.selectCasts.push({image:null,title: "選択してください",isOpened:false})


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
