angular.module 'bisyoujoZukanNight'
.directive 'shopMassageIndexDirective', ($state) ->
  ShopMassageIndexController = (shopService, customerService, modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'MASSAGE GROUP',link:''}]
      vm.getShops()

    vm.getShops = ->
      shopService.getShopList({job_type: 'massage'}).then((res) ->
        vm.push_shops = res.data.push_shops
        vm.shops = res.data.shops
        vm.total = res.data.total
        vm.favorites = res.data.favorites
      )

    vm.onClickedFavorite = (opt_cast_id)->
      vm.favoriteShopId = opt_cast_id
      if customerService.isLogin()
        vm.loginCustomer = customerService.getLoginCustomer()
        vm.CountUpFavorite()
      else
        modalService.createCustomer(vm.setLoginCustomer)

    vm.setLoginCustomer = (loginUser) ->
      customerService.setLoginCustomer(loginUser)
      vm.loginCustomer = customerService.getLoginCustomer()
      vm.CountUpFavorite()


    vm.CountUpFavorite = ->
      params = {
        type: 'favorite'
        sender_type: 'Customer'
        sender_id: vm.loginCustomer.id
        receiver_id: vm.favoriteShopId
        receiver_type: 'Shop'
      }
      shopService.pushPost(params).then((res) ->
        vm.favorites = res.data.favorites
        title = res.data.message
        modalService.alert(title)
      )




    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ShopMassageIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
