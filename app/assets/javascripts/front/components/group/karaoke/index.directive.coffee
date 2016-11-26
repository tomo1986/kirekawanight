angular.module 'bisyoujoZukanNight'
.directive 'groupKaraokeIndexDirective', ($state) ->
  GroupKaraokeIndexController = (groupService, customerService, modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'TOP',link:'/'},{name:'KARAOKE GROUP',link:''}]
      vm.getGroups()

    vm.getGroups = ->
      groupService.getGroupList({job_type: 'karaoke'}).then((res) ->
        vm.push_groups = res.data.push_groups
        vm.groups = res.data.groups
        vm.total = res.data.total
        vm.favorites = res.data.favorites
      )

      vm.onClickedFavorite = (opt_cast_id)->
        vm.favoriteGroupId = opt_cast_id
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
        receiver_id: vm.favoriteGroupId
        receiver_type: 'Group'
      }
      groupService.pushPost(params).then((res) ->
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
    controller: GroupKaraokeIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
