angular.module 'bisyoujoZukanNight'
.directive 'castDetailDirective', ($state,$sce,castService, modalService,customerService, NgMap, validationService) ->
  CastDetailController = () ->
    vm = this
    vm.init = ->
      $state.go '.info' if $state.current.default_url == 'base'
      vm.page = 1

      vm.breadcrumb = [{name:'キレカワ',link:'/'}]
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
        vm.breadcrumb.push({name:'CAST',link:"/casts/#{vm.cast.job_type}?page=1"}) if vm.cast
        vm.breadcrumb.push({name:vm.cast.shop.name, link:"/shops/#{vm.cast.job_type}/#{vm.cast.shop.id}/info"}) if vm.cast.shop
        vm.breadcrumb.push({name:vm.cast.name, link:''})

        vm.cast['profile'] = res.data.profile
        vm.isFavorited = res.data.is_favorited
        vm.castMainImg = vm.cast.images[0].url if vm.cast.images[0]
        vm.cast.profile.interview = $sce.trustAsHtml(vm.cast.profile.interview)
      )


    vm.onClickedSupport = ->
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpSupport()
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.setLoginCustomer = (loginUser) ->
      console.log(loginUser)
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
      return if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      castService.sendContact(vm.contact).then((res) ->
        title = 'お問い合わせありがとうざいました。'
        message = '女性からの連絡をお待ちください'
        modalService.alert(title,message)
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
    controller: CastDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
