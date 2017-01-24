angular.module 'bisyoujoZukanNight'
.directive 'shopDetailReviewDirective', (shopService, modalService, customerService, $state,$rootScope) ->
  ShopDetailReviewController = () ->
    vm = this
    vm.init = ->
      vm.isLoading = true
      vm.reviews = []
      vm.filters ={
        id: vm.parentCtrl.pageId
        limit: 10
        page: if $state.params.page then $state.params.page else 1
        sort: if $state.params.sort then $state.params.sort else 'new'
        order: if $state.params.order then $state.params.order else 'desc'
      }
      vm.getReviews()

    vm.getReviews = ->
      vm.isLoading = true
      shopService.getReviews(vm.filters).then((res) ->
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
      vm.loginCustomer = customerService.getLoginCustomer()
      params = {
        type: if answer == 'yes' then 'reference' else 'not_reference'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer
        receiver_id: review.id
        receiver_type: 'Review'
      }
      shopService.pushPost(params).then((res) ->
        title = res.data.title
        message = res.data.message
        vm.isFavorited = res.data.is_favorited
        modalService.alert(title,message)
      )




    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'E'
    scope:{
      parentCtrl: "="
    }
    controller: ShopDetailReviewController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/shops/common/_reviews.html"
    bindToController: true

