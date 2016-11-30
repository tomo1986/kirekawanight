angular.module 'bisyoujoZukanNight'
.directive 'castMassageDetailDirective', ($state,castService, modalService,customerService) ->
  CastMassageDetailController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'MASSAGE CAST',link:''}]
      vm.selectSns = 'Zalo'
      vm.active_language = 'ja'
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.profile = castService.profile
      vm.canReviewSubmited = true
      vm.serviceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.servingScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.girlScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.ambienceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.againScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}

      vm.contact = {
        type: 'user_detail'
        subject_type: 'User'
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
        type: 'user'
        sender_type: 'Customer'
        sender_id: if vm.loginCustomer then vm.loginCustomer.id else null
        receiver_type: 'User'
        receiver_id: $state.params.id
        service_score: 1
        serving_score: 1
        girl_score: 1
        ambience_score: 1
        again_score: 1
        comment: null
      }
      vm.getCast()

    vm.getCast = ->
      castService.getCast($state.params.id).then((res) ->
        vm.cast = res.data.user
        vm.breadcrumb.push({name:vm.cast.name, link:''})
        vm.cast['profile'] = res.data.profile
        vm.casts = res.data.users
        vm.isFavorited = res.data.is_favorited
        vm.castMainImg = vm.cast.images[0].url
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
        receiver_type: 'User'
      }
      castService.pushSupport(params).then((res) ->
        vm.cast.support_count = res.data.support_count
        title = res.data.title
        message = res.data.message
        modalService.alert(title,message)
      )
    vm.setLoginCustomerToFavorite = (loginUser) ->
      customerService.setLoginCustomer(loginUser)
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.CountUpFavorite()

    vm.onClickedFavorite = ->
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpFavorite()
      else
        modalService.createCustomer(vm.setLoginCustomerToFavorite)

    vm.CountUpFavorite = ->
      params = {
        type: 'favorite'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer.id
        receiver_id: $state.params.id
        receiver_type: 'User'
      }
      castService.pushSupport(params).then((res) ->
        vm.favorites = res.data.favorites
        vm.isFavorited = res.data.is_favorited
        vm.cast.favorite_count = res.data.favorite_count
        title = res.data.title
        message = res.data.message
        modalService.alert(title, message)

      )

    vm.onClickedImage = (opt_no) ->
      vm.castMainImg = vm.cast.images[opt_no].url

    vm.submit = ->
      vm.errors = {}
      vm.errors['name'] = '氏名を入力してくだい。' if !vm.contact.name
      if vm.contact.return_way == 'email'
        vm.errors['email'] = 'emailを入力してくだい。' if !vm.contact.email
      else if vm.contact.return_way == 'tel'
        vm.errors['tel'] = 'TELを入力してくだい。' if !vm.contact.tel
      else if vm.contact.return_way == 'sns'
        if vm.selectSns == 'zalo'
          vm.errors['sns'] = 'Zaloアカウントを入力してくだい。' if !vm.contact.sns_zalo
          vm.contact.sns_wechat = null
          vm.contact.sns_line = null
        else if vm.selectSns == 'wechat'
          vm.errors['sns'] = 'Wechatアカウントを入力してくだい。' if !vm.contact.sns_wechat
          vm.contact.sns_zalo = null
          vm.contact.sns_line = null
        else if vm.selectSns == 'line'
          console.log("asdfasdfasd")
          vm.errors['sns'] = 'LINEアカウントを入力してくだい。' if !vm.contact.sns_line

          vm.contact.sns_zalo = null
          vm.contact.sns_wechat = null

      console.log(vm.errors,vm.selectSns == 'line')
      console.log(vm.contact)
      return if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      castService.sendContact(vm.contact).then((res) ->
        title = 'ありがとうざいました。'
        message = 'こちらからご連絡させていただきます。その際kirekarwa colection 事務局からご連絡させていただきます。'
        modalService.alert(title,message)
      )
    vm.reviewSubmit = ->
      vm.canReviewSubmited = false

      castService.sendReview(vm.review).then((res) ->
        vm.canReviewSubmited = true
        title = '受け付けました。'
        message = '貴重なreviewありがとうございました改善に努めていきます。'
        modalService.alert(title,message)
        vm.review = {
          type: 'user'
          sender_type: 'Customer'
          sender_id: if vm.loginCustomer then vm.loginCustomer.id else null
          receiver_type: 'User'
          receiver_id: $state.params.id
          service_score: 1
          serving_score: 1
          girl_score: 1
          ambience_score: 1
          again_score: 1
          comment: null
        }
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: CastMassageDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
