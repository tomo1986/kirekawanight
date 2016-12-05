angular.module 'bijyoZukanAdmin'
.directive 'shopFormDirective',  ->
  ShopFormController = (shopService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Shop',link:''}]
      vm.open_options={
        from:{is_from:true,date:null}
        used: 'timePicker'
        timepickerOptions: {
          readonlyInput: false
          showMeridian: false
        }
        format: 'HH:mm'
        is_required:true
        placeholder:'必須'
      }
      vm.close_options={
        to:{is_from:true,date:null}
        used: 'timePicker'
        timepickerOptions: {
          readonlyInput: false
          showMeridian: false
        }
        format: 'HH:mm'
        is_required:true
        placeholder:'必須'
      }

      vm.images = []

      vm.active_tab = 'ja'
      vm.loaded = false
      vm.options =
        allowedContent: true
        entities: false
      vm.getTags()
      vm.getGroups()
      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getShop()
      else
        vm.newShop()
        vm.breadcrumb.push({name:'New Shop',link:''})

    vm.getGroups = ->
      shopService.getGroups().then((res) ->
        vm.groups = res.data.groups
      )
    vm.getTags = ->
      shopService.getTags().then((res) ->
        vm.tags = res.data.tags
      )
    vm.onClickTag = (opt_tag) ->
      isFirst = true
      canAdd = true
      angular.forEach(vm.shop.tags, (tag) ->
        if canAdd || isFirst
          if tag.id != opt_tag.id
            canAdd = true
          else
            canAdd = false
        isFirst = false
      )
      vm.shop.tags.push(opt_tag) if canAdd


    vm.getShop = ->
      shopService.getShop($state.params.id).then((res) ->
        vm.shop = res.data.shop
        angular.forEach(vm.shop.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,aspectRatio:"NaN"}
          })
        )
      )
    vm.newShop = ->
      shopService.newShop().then((res) ->
        vm.shop = res.data.shop
        vm.shop["password"] = ''
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
      vm.errors = null
      vm.errors = validationService.checks(vm.shop,shopService.getValidationRule())
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
      vm.shop['images'] = images
      title = "We saved finish "
      buttons = [
        {name:'一覧へ戻る',link:"/admin/shops"}
        {name:'新しいカプセル追加',link:"/admin/shops/new",callbackFunc: vm.init}
      ]

      if vm.action == 'update'

        shopService.updateShop(vm.shop).then((res) ->
          if res.data.code == 1
            vm.shop = res.data.shop
            datas = vm.makeDataForModal(vm.shop)
            console.log(title,datas,buttons)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        shopService.createShop(vm.shop).then((res) ->
          if res.data.code == 1
            vm.shop = res.data.shop
            datas = vm.makeDataForModal(vm.shop)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )


    vm.makeDataForModal = (shop)->
      return [
        {name:"name", val: shop.name, kind:"string"}
        {name:"name_kana", val: shop.name_kana, kind:"string"}
        {name:"tel", val: shop.tel, kind:"string"}
        {name:"email", val:shop.email, kind:"string"}
        {name:"job_type", val:shop.job_type, kind:"string"}
        {name:"address", val:shop.address, kind:"string"}
        {name:"is_credit", val:shop.is_credit, kind:"string"}
        {name:"is_smoked", val:shop.is_smoked, kind:"string"}
        {name:"chip", val:shop.chip, kind:"string"}
        {name:"budget_usd", val:shop.budget_usd, kind:"number"}
        {name:"budget_vnd", val:shop.budget_vnd, kind:"number"}
        {name:"budget_usd", val:shop.budget_usd, kind:"number"}
        {name:"opened_at", val:shop.opened_at, kind:"date"}
        {name:"closed_at", val:shop.closed_at, kind:"number"}
        {name:"interview(japanese)", val:shop.interview_ja, kind:"text"}
      ]

    vm.onReady = ->
      vm.loaded = true
      return

    vm.onChangeTab = (opt_tab) ->
      vm.active_tab = opt_tab

    vm.callbackGetLocationAddress = (ido,keido,address) ->
      vm.shop.lon = parseFloat(ido)
      vm.shop.lat = parseFloat(keido)
      vm.shop.address = address

    vm.getAddressFromMap = () ->
      position = {
        location: [vm.shop.lon,vm.shop.lat]
        address: vm.shop.address
      }
      modalService.getAddress(position, vm.callbackGetLocationAddress)


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
#    scope.$watch("vm.shop.group_id",(newVal,oldVal) ->
#      if newVal != oldVal && oldVal != undefined
#        angular.forEach(scope.vm.groups,(group) ->
#          scope.vm.user.job_type = shop.job_type if Number(newVal) == Number(shop.id)
#        )
#    )

    return

  directive =
    restrict: 'A'
    controller: ShopFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
