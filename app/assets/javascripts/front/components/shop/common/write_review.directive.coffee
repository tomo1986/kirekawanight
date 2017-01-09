angular.module 'bisyoujoZukanNight'
.directive 'shopDetailWriteReviewDirective', (shopService, modalService, customerService,validationService, $state) ->
  ShopDetailWriteReviewController = () ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.serviceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.servingScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.girlScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.ambienceScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.againScoreAange = {minValue: 1,maxValue: 5,options: {floor: 1,ceil: 5,showTicks: true,showTicks: 1,step: 1}}
      vm.canReviewSubmited = true
      vm.review = {
        type: 'shop'
        sender_type: 'Customer'
        sender_id: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.id else null
        receiver_type: 'Shop'
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
        review: null
      }


    vm.reviewSubmit = ->
      vm.reviewErrors = null
      vm.reviewErrors = validationService.checks(vm.review, shopService.reviewValidations)
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
          sender_id: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.id else null
          receiver_type: 'Shop'
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
          review: null
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
    $ ->
      min = 50
      $('#kuchikomi').bind 'keyup', ->
        thisValueLength = $('#kuchikomi').val().replace(/\s+/g, '').length
        $(".kuchikomi-count").html(thisValueLength);
#        if min >= thisValueLength
#          $("#submit").prop("disabled", true)
#        else
#          $("#submit").prop("disabled", false)
    return
  directive =
    restrict: 'E'
    scope:{
      parentCtrl: "="
    }
    controller: ShopDetailWriteReviewController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/shops/common/_write_review.html"
    bindToController: true

