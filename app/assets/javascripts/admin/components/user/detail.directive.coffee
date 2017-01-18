angular.module 'bijyoZukanAdmin'
.directive 'userDetailDirective',  ->
  UserDetailController = (user,$state) ->
    vm = this
    self = vm
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.images = []
      vm.face_images = []
      vm.active_tab = 'ja'
      vm.profile = user.profile
      vm.action = $state.current.action
      vm.chartLineOptions = {
        padding:{top: 10,right: 10,bottom: 20,left: 10}
        showY:true
        showX:true
        legend:true
        tooltip:true
        height:'100px'
        chartColor:'#fff'
      }
      vm.getUser()
      vm.getDate()
      vm.getContacts()
    vm.getDate = ->
      user.getDate($state.params.id).then((res) ->
        console.log(res.data)
        vm.chartLine1 = res.data.chart_date
        vm.monthly_contact_count = res.data.monthly_contact_count
        vm.monthly_favorite_count = res.data.monthly_favorite_count
        vm.monthly_pv_count = res.data.monthly_pv_count
        vm.monthly_support_count = res.data.monthly_support_count
        vm.monthly_review_count = res.data.monthly_review_count
      )
    vm.getContacts = ->
      user.getContacts($state.params.id).then((res) ->
        vm.contacts = res.data.contacts
        vm.reviews = res.data.reviews
      )

    vm.getUser = ->
      user.getUser($state.params.id).then((res) ->
        vm.user = res.data.user
        angular.forEach(vm.user.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
          })
        )
        angular.forEach(vm.user.face_images, (image) ->
          vm.face_images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
          })
        )

      )

    vm.onChangeTab = (opt_tab) ->
      vm.active_tab = opt_tab

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: UserDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
