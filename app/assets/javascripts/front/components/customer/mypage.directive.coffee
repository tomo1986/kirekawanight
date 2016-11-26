angular.module 'bisyoujoZukanNight'
.directive 'customerMypageDirective', ($state,castService,customerService,modalService , api) ->
  CustomerMypageController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'TOP',link:'/'},{name:'MYPAGE',link:''}]
      vm.getFavorited()
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
    return
  directive =
    restrict: 'A'
    controller: CustomerMypageController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
