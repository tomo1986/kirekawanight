angular.module 'bijyoZukanAdmin'
.directive 'bannerFormDirective',  ->
  BannerFormController = (user, modalService,datePickerService,$state,validationService, bannerService) ->
    vm = this
    console.log("aaaaaaaaa")
    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.active_tab = 'ja'
      vm.subjectList = []
      vm.image = {
        id: null
        url: null
        original_url: null
        options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,aspectRatio:"NaN"}
      }

      vm.start_at_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }
      vm.end_at_options={
        from:{is_from:true,date:null}
        enable_time: false
        format: 'yyyy-MM-dd'
        is_required:true
        placeholder:'必須'
      }

      vm.loaded = false
      vm.content = '<h1>Hello</h1>'

      vm.ckOptions =
        allowedContent: true
        entities: false
      vm.action = $state.current.action

      if vm.action == 'update'
        vm.getBanner()
      else
        vm.breadcrumb.push({name:'MAP新規作成',link:''})
        vm.newBanner()
    vm.getBanner = ->
      bannerService.getBanner($state.params.id).then((res) ->
        vm.banner = res.data.banner
        vm.image = {
          id: vm.banner.image.id
          url: vm.banner.image.url
          original_url: vm.banner.image.url
          options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,aspectRatio:"NaN"}
        }

        vm.getSubjects()
      )

    vm.newBanner = ->
      bannerService.newBanner().then((res) ->
        vm.banner = res.data.banner
        vm.getSubjects()
      )
    vm.getSubjects = () ->
      bannerService.getSubjects().then((res) ->
        vm.users = res.data.users
        vm.groups = res.data.groups
        if vm.banner.subject_type == 'Group'
          vm.subjectList = vm.groups
        else if vm.banner.subject_type == 'User'
          vm.subjectList = vm.users
      )



    vm.onReady = ->
      vm.loaded = true
      return

    vm.onChangeTab = (opt_tab) ->
      vm.active_tab = opt_tab

    vm.submit = ->
      image = null
      if vm.image.original_url != vm.image.url
        image = {id: vm.image.id,url: vm.image.url}

      buttons = [
        {name:'一覧へ戻る',link:"/admin/pickups"}
      ]
      vm.banner['image'] = image
      if vm.action == 'update'
        bannerService.updateBanner(vm.banner).then((res) ->
          vm.banner = res.data.banner
          modalService.confirm("hozonsiha")
        )
      else
        bannerService.createBanner(vm.banner).then((res) ->
          vm.banner = res.data.banner
          modalService.confirm("hozonsiha")
        )




    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    scope.$watch("vm.banner.subject_type",(val) ->
      if val == 'Group'
        scope.vm.subjectList = scope.vm.groups
      else if val == 'User'
        scope.vm.subjectList = scope.vm.users
    )
    return

  directive =
    restrict: 'A'
    controller: BannerFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
