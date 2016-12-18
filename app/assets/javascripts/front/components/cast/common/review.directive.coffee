angular.module 'bisyoujoZukanNight'
.directive 'castDetailReviewDirective', (castService, modalService, customerService, $state) ->
  CastDetailReviewController = () ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.reviews = []
      vm.filters ={
        id: $state.params.id
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
      }
      vm.isLoading = true
      vm.serviceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.servingScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.girlScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.ambienceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.againScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.canReviewSubmited = true
      vm.review = {
        type: 'cast'
        sender_type: 'Customer'
        sender_id: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.id else null
        receiver_type: 'User'
        receiver_id: $state.params.id
        score1: 1
        score2: 1
        score3: 1
        score4: 1
        score5: 1
        info1: ""
        info2: ""
        info3: ""
        info4: ""
        info5: ""
        title: null
        comment: null
        is_draft: false
      }

      vm.getReviews()

    vm.getReviews = ->
      vm.isLoading = true
      castService.getReviews(vm.filters).then((res) ->
        if res.data.code == 1
          vm.total = res.data.total
          angular.forEach(res.data.reviews, (review) ->
            vm.reviews.push(review)
          )
          vm.isLoading = false
      )

    vm.onAddReviews = ->
      vm.filters.page++
      vm.changePageFunk()

    vm.changePageFunk = ->
      vm.getReviews()

    vm.setLoginCustomer = (loginUser) ->
      customerService.setLoginCustomer(loginUser)
      vm.parentCtrl.loginCustomer = customerService.getLoginCustomer()
      vm.CountUpReference()


    vm.onClickedReference = (review,answer) ->
      vm.review = review
      console.log(vm.review)

      if customerService.isLogin()
        vm.parentCtrl.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpReference(review,answer)
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.CountUpReference = (review,answer) ->
      params = {
        type: if answer == 'yes' then 'reference' else 'not_reference'
        sender_type: 'Customer'
        sender_id: vm.parentCtrl.loginCustomer.id
        receiver_id: review.id
        receiver_type: 'Review'
      }
      castService.pushPost(params).then((res) ->
        title = res.data.title
        message = res.data.message
        vm.isFavorited = res.data.is_favorited
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
          type: 'cast'
          sender_type: 'Customer'
          sender_id: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.id else null
          receiver_type: 'User'
          receiver_id: $state.params.id
          score1: 1
          score2: 1
          score3: 1
          score4: 1
          score5: 1
          info1: ""
          info2: ""
          info3: ""
          info4: ""
          info5: ""
          title: null
          comment: null
          is_draft: false
        }
      )

    vm.onInfo1 = (val) -> vm.review.info1 = val
    vm.onInfo2 = (val) -> vm.review.info2 = val
    vm.onInfo3 = (val) -> vm.review.info3 = val
    vm.onInfo4 = (val) -> vm.review.info4 = val
    vm.onInfo5 = (val) -> vm.review.info5 = val



    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'E'
    scope:{
      parentCtrl: "="
    }
    controller: CastDetailReviewController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/casts/common/_reviews.html"
    bindToController: true

