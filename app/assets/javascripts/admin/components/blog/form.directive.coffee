angular.module 'bijyoZukanAdmin'
.directive 'blogFormDirective', ->
  BlogFormController = (blogService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'Blog',link:'/business/maps'}]
      vm.images = []

      vm.active_tab = 'ja'
      vm.loaded = false
      vm.options =
        allowedContent: true
        entities: false

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getBlog()
      else
        vm.newBlog()
        vm.breadcrumb.push({name:'MAP新規作成',link:''})

    vm.getBlog = ->
      blogService.getBlog($state.params.id).then((res) ->
        vm.blog = res.data.blog
        angular.forEach(vm.blog.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,aspectRatio:"NaN"}
          })
        )
      )

    vm.newBlog = ->
      blogService.newBlog().then((res) ->
        vm.blog = res.data.blog
        vm.blog["password"] = ''
        vm.images.push({
          id: null
          url: null
          original_url: null
          options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,zoomable: true,aspectRatio: "NaN"}
        })
      )
    vm.addImage = ->
      vm.images.push({
        id: null
        url: null
        original_url: null
        options:{zoomable: true,aspectRatio: "NaN"}
      })

    vm.submit = ->
      images = []
      imageUploaded = $('.image-box--arry image-directive img')
      if imageUploaded.length > 0
        $.each(imageUploaded, (index,value)->
          if vm.images[index].original_url != vm.images[index].url
            images.push({id: vm.images[index].id, url:vm.images[index].url})
        )
      vm.blog['images'] = images
      title = "save as "
      buttons = [
        {name:'一覧へ戻る',link:"/admin/blogs"}
        {name:'新しいカプセル追加',link:"/admin/blogs/new",callbackFunc: vm.init}
      ]
      vm.canSubmit = false
      if vm.action == 'update'
        blogService.updateBlog(vm.blog).then((res) ->
          if res.data.code == 1
            vm.blog = res.data.blog
            datas = vm.makeDataForModal()
            console.log(title,datas,buttons)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        blogService.createBlog(vm.blog).then((res) ->
          if res.data.code == 1
            vm.blog = res.data.blog
            datas = vm.makeDataForModal()
            modalService.confirm(title,datas,buttons)
            vm.canSubmit = true
          else
            modalService.error(res.data.errors)
        )


    vm.makeDataForModal = ->
      return [
        {name:"ブログタイトル",val:vm.blog.title_ja,kind:"string"}
        {name:"タイトル",val:vm.blog.head_title_ja,kind:"string"}
        {name:"キーワード",val:vm.blog.head_keyword_ja,kind:"string"}
        {name:"job_type",val:vm.blog.job_type,kind:"string"}
        {name:"本文",val:vm.blog.article_ja,kind:"text"}
      ]


    vm.getUsers = (type) ->
      blogService.getUsers({job_type: type}).then((res) ->
        if res.data.code == 1
          vm.items = res.data.users
        else
          modalService.error(res.data.errors)
      )
    vm.getShops = (type) ->
      blogService.getUsers({job_type: type}).then((res) ->
        if res.data.code == 1
          vm.items = res.data.users
        else
          modalService.error(res.data.errors)
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.blog.subject_type",(val) ->
      if val == 'Karaoke'
        type = 'karaoke'
      else if val == 'Bar'
        type = 'bar'
      else if val == 'Massage'
        type = 'massage'
      if scope.vm.blog && scope.vm.blog.type == 'User'
        scope.vm.getUsers(type)
      else if  scope.vm.blog && scope.vm.blog.type == 'Shop'
        scope.vm.getShops(type)
    )


    return

  directive =
    restrict: 'A'
    controller: BlogFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
