angular.module 'bisyoujoZukanNight'
.directive 'groupMassageDetailDirective', ($state,groupService, modalService,customerService, NgMap, validationService) ->
  GroupMassageDetailController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'TOP',link:'/'},{name:'MASSAGE SHOP',link:'/groups/massage'}]
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
        type: 'group_detail'
        subject_type: 'Group'
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
        type: 'group'
        sender_type: 'Customer'
        sender_id: if vm.loginCustomer then vm.loginCustomer.id else null
        receiver_type: 'Group'
        receiver_id: $state.params.id
        service_score: 1
        serving_score: 1
        girl_score: 1
        ambience_score: 1
        again_score: 1
        comment: null
      }

      vm.getGroup()
    NgMap.getMap().then((map) ->
      vm.ngMap = map
    )

    vm.getGroup = ->
      groupService.getGroup($state.params.id).then((res) ->
        vm.group = res.data.group
        vm.reviews = res.data.reviews
        vm.isFavorited = res.data.is_favorited
        vm.breadcrumb.push({name:vm.group.name, link:''})
        vm.casts = res.data.users
        vm.groupMainImg = vm.group.images[0].url
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
        receiver_type: 'Group'
      }
      groupService.pushPost(params).then((res) ->
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
        receiver_type: 'Group'
      }
      groupService.pushPost(params).then((res) ->
        vm.favorites = res.data.favorites
        title = res.data.message
        modalService.alert(title)
      )

    vm.onClickedImage = (opt_no) ->
      vm.groupMainImg = vm.group.images[opt_no].url

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
      groupService.sendContact(vm.contact).then((res) ->
        vm.canContactSubmited = true
        title = '受け付けました。'
        message = '回答を授時行っております。今しばらくお待ちください。'
        modalService.alert(title,message)
        vm.contact = {
          type: 'group_detail'
          subject_type: 'Group'
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
      vm.reviewErrors = validationService.checks(vm.review, groupService.reviewValidations)
      console.log(vm.reviewErrors)
      return if Object.keys(vm.reviewErrors) && Object.keys(vm.reviewErrors).length > 0

      vm.canReviewSubmited = false
      groupService.sendReview(vm.review).then((res) ->
        vm.canReviewSubmited = true
        title = '受け付けました。'
        message = '貴重なreviewありがとうございました改善に努めていきます。'
        modalService.alert(title,message)
        vm.review = {
          type: 'group'
          sender_type: 'Customer'
          sender_id: vm.loginCustomer.id
          receiver_type: 'Group'
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
    controller: GroupMassageDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
