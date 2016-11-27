angular.module 'bijyoZukanGroup'
.directive 'userFormDirective',  ->
  UserFormController = (user, modalService,datePickerService,$state,validationService,groupService) ->
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



      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getUser()
      else
        vm.newUser()
        vm.breadcrumb.push({name:'MAP新規作成',link:''})


    vm.getSubjects = ->
      groupService.loginGroup().then((res) ->
        vm.group = res.data.group
        vm.user.group_id = vm.group.id
        vm.user.job_type = vm.group.job_type
        console.log(vm.group)
        console.log(vm.user)

      )
    vm.getUser = ->
      user.getUser($state.params.id).then((res) ->
        vm.user = res.data.user
        vm.getSubjects()
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
        vm.getSubjects()
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
      console.log(vm.group.id)
      vm.user.group_id = vm.group.id
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
        {name:'一覧へ戻る',link:"/group/users"}
        {name:'新しいカプセル追加',link:"/group/users/new",callbackFunc: vm.init}
      ]
      if vm.action == 'update'
        user.updateUser(vm.user).then((res) ->
          if res.status == 1
            vm.user = res.data.user
            datas = vm.makeDataForModal(vm.user)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        user.createUser(vm.user).then((res) ->
          if res.status == 1
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
    return

  directive =
    restrict: 'A'
    controller: UserFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
