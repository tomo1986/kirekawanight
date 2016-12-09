angular.module 'bisyoujoZukanNight'
.directive 'castSexyDetailDirective', ($state,castService, modalService,customerService) ->
  CastSexyDetailController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'SEXY CAST',link:'/casts/sexy'}]
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
      vm.contactValidations = {
        rules: {
          email: {required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
        }
        messages: {
          email: {required: 'emailが入力されていません。',regexp:"Emailが正しくありません。"}
        }
      }

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
      if vm.selectSns == 'zalo'
        vm.errors['sns'] = 'Zaloアカウントを入力してくだい。' if !vm.contact.sns_zalo
        vm.contact.sns_wechat = null
        vm.contact.sns_line = null
      else if vm.selectSns == 'wechat'
        vm.errors['sns'] = 'Wechatアカウントを入力してくだい。' if !vm.contact.sns_wechat
        vm.contact.sns_zalo = null
        vm.contact.sns_line = null
      else if vm.selectSns == 'line'
        vm.errors['sns'] = 'LINEアカウントを入力してくだい。' if !vm.contact.sns_line
        vm.contact.sns_zalo = null
        vm.contact.sns_wechat = null
      return if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      castService.sendContact(vm.contact).then((res) ->
        title = '受け付けました。'
        message = '今しばらくお待ちください。'
        modalService.alert(title,message)
      )


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: CastSexyDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
