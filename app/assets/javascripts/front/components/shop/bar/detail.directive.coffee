angular.module 'bisyoujoZukanNight'
.directive 'shopBarDetailDirective', ($state,shopService, modalService,customerService, NgMap, validationService) ->
  ShopBarDetailController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'KARAOKE SHOP',link:'/shops/bar'}]
      vm.isAttention = false

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
        message: '何かあれば書いてください'
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
    vm.changeContents = (opt_content) ->
      vm.displayContent = opt_content

    NgMap.getMap().then((map) ->
      vm.ngMap = map
    )

    vm.getShop = ->
      shopService.getShop($state.params.id).then((res) ->
        if res.data.code == 1
          vm.shop = res.data.shop
          vm.reviews = res.data.reviews
          vm.isFavorited = res.data.is_favorited
          vm.breadcrumb.push({name:vm.shop.name, link:''})
          vm.newCasts = res.data.new_users
          vm.casts = res.data.users
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
        console.log("fasdfa",vm.isFavorited)
        modalService.alert(title,message)
      )

    vm.onClickedImage = (opt_no) ->
      vm.shopMainImg = vm.shop.images[opt_no].url

    vm.contactSubmit = ->
      vm.contactErrors = {}
      vm.contactErrors['name'] = '氏名を入力してくだい。' if !vm.contact.name
      if vm.contact.return_way == 'email'
        vm.contactErrors['email'] = 'emailを入力してくだい。' if !vm.contact.email
      else if vm.contact.return_way == 'tel'
        vm.contactErrors['tel'] = 'TELを入力してくだい。' if !vm.contact.tel
      else if vm.contact.return_way == 'sns'
        if vm.selectSns == 'zalo'
          vm.contactErrors['sns'] = 'Zaloアカウントを入力してくだい。' if !vm.contact.sns_zalo
          vm.contact.sns_wechat = null
          vm.contact.sns_line = null
        else if vm.selectSns == 'wechat'
          vm.contactErrors['sns'] = 'Wechatアカウントを入力してくだい。' if !vm.contact.sns_wechat
          vm.contact.sns_zalo = null
          vm.contact.sns_line = null
        else if vm.selectSns == 'line'
          vm.contactErrors['sns'] = 'LINEアカウントを入力してくだい。' if !vm.contact.sns_line
          vm.contact.sns_zalo = null
          vm.contact.sns_wechat = null
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0
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
          message: '何かあれば書いてください'
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

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ShopBarDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
