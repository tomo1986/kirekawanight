angular.module 'bijyoZukanAdmin'
.directive 'userFormDirective',  ->
  UserFormController = (user, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm
    vm.init = ->
      vm.canSubmit = true
      vm.image_url = null
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.images = []
      vm.active_tab = 'ja'
      vm.profile = user.profile
      vm.birthday_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'

      }
      vm.loaded = false
      vm.content = '<h1>Hello</h1>'

      vm.options =
        allowedContent: true
        entities: false

      vm.allShops()
      vm.getTags()

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getUser()
      else
        vm.newUser()
        vm.breadcrumb.push({name:'New User',link:''})


    vm.allShops = ->
      user.allShops().then((res) ->
        vm.shops = res.data.shops
      )
    vm.getTags = ->
      user.getTags().then((res) ->
        vm.tags = res.data.tags
      )
    vm.onClickTag = (opt_tag) ->
      isFirst = true
      canAdd = true
      angular.forEach(vm.user.tags, (tag) ->
        if canAdd || isFirst
          if tag.id != opt_tag.id
            canAdd = true
          else
            canAdd = false
        isFirst = false
      )
      vm.user.tags.push(opt_tag) if canAdd

    vm.getUser = ->
      user.getUser($state.params.id).then((res) ->
        vm.user = res.data.user
        vm.user["is_blog"] = 0
        angular.forEach(vm.user.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
          })
        )
      )

    vm.newUser = () ->
      user.newUser().then((res) ->
        vm.user = res.data.user
        vm.user["is_blog"] = 0
        vm.images.push({
          id: null
          url: null
          original_url: null
          options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
        })

      )

    vm.onReady = ->
      vm.loaded = true
      return

    vm.onChangeTab = (opt_tab) ->
      vm.active_tab = opt_tab

    vm.addImage = ->
      vm.images.push({
        id: null
        url: null
        original_url: null
        options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
      })

    vm.submit = ->
      console.log(vm.user.tags)
      vm.errors = null
      vm.errors = validationService.checks(vm.user,user.getValidationRule())
      console.log(vm.errors)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      images = []
      imageUploaded = $('.image-box--arry image-directive img')
      if imageUploaded.length > 0
        $.each(imageUploaded, (index,value)->
          if vm.images[index].original_url != vm.images[index].url
            if vm.action == 'update'
              images.push({id: vm.images[index].id, url:vm.images[index].url})
            else
              images.push(vm.images[index].url)
        )
      vm.user['images'] = images
      console.log(vm.user)
      title = "We saved finish"
      buttons = [
        {name:'一覧へ戻る',link:"/admin/users"}
        {name:'新しいカプセル追加',link:"/admin/users/new",callbackFunc: vm.init}
      ]
      if vm.action == 'update'
        user.updateUser(vm.user).then((res) ->
          if res.data.code == 1
            vm.user = res.data.user

            datas = vm.makeDataForModal(vm.user)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        user.createUser(vm.user).then((res) ->
          if res.data.code == 1
            vm.user = res.data.user
            datas = vm.makeDataForModal(vm.user)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
    vm.makeDataForModal = (user)->
      return [
        {name:"name", val: user.name, kind:"string"}
        {name:"nick_name", val: user.nick_name, kind:"string"}
      ]

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.user.shop_id",(newVal,oldVal) ->
      if newVal != oldVal && oldVal != undefined
        angular.forEach(scope.vm.shops,(shop) ->
          scope.vm.user.job_type = shop.job_type if Number(newVal) == Number(shop.id)
        )
    )
    return

  directive =
    restrict: 'A'
    controller: UserFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
