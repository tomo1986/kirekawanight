angular.module 'bijyoZukanAdmin'
.directive 'shopFormDirective',  ->
  ShopFormController = (shopService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.menus = []
      vm.coupons = []
      vm.visa = null
      vm.master = null
      vm.jcb = null
      vm.amex = null
      vm.shopId = $state.params.id

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
      vm.copensDaterPicker ={

      }
      vm.images = []
      vm.way_images = []

      vm.active_tab = 'ja'
      vm.loaded = false
      vm.options =
        allowedContent: true
        entities: false
      vm.getTags()
      vm.getGroups()
      vm.getAdmins()

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getShop()
        vm.getMenus()
        vm.getCoupons()
      else
        vm.newShop()
        vm.getNewMenu()
        vm.breadcrumb.push({name:'New Shop',link:''})
    vm.getMenus = ->
      shopService.getMenus({shop_id: $state.params.id }).then((res) ->
        if res.data.code == 1
          angular.forEach(res.data.menus,(menu)->
            vm.menus.push(menu)
          )
          vm.getNewMenu() if vm.menus.length == 0
      )
    vm.getCoupons = ->
      shopService.getCoupons({id: $state.params.id }).then((res) ->
        if res.data.code == 1
          angular.forEach(res.data.coupons,(coupon)->
            vm.coupons.push(coupon)
          )
          vm.getNewCoupon() if vm.coupons.length == 0
      )
    vm.getNewCoupon = ->
      shopService.getNewCoupon().then((res) ->
        if res.data.code == 1
          vm.coupons.push(res.data.coupon)
      )

    vm.setCoupon = (coupon,index) ->
      coupon.subject_id = if coupon.type == "menu" then coupon.subject_id else $state.params.id
      params = {
        id: if coupon.id then coupon.id else null
        type: coupon.type
        subject_id: coupon.subject_id
        description: coupon.description
        sub_description: coupon.sub_description
        started_at: coupon.started_at
        end_at: coupon.end_at
        is_displayed: coupon.is_displayed
        sort_no: coupon.sort_no
      }
      shopService.getUpdateCoupon(params).then((res) ->
        if res.data.code == 1
          vm.coupons[index] = res.data.coupon
          modalService.error('保存しました。')
      )
    vm.deleteCoupon = (coupon,index) ->
      if coupon.id
        shopService.getDeleteCoupon(coupon).then((res) ->
          if res.data.code == 1
            vm.coupons.splice(index, 1)
            modalService.error('削除しました。')
        )
      else
        vm.coupons.splice(index, 1)
    vm.addCoupon = ->
      vm.getNewCoupon()



    vm.getNewMenu = ->
      shopService.getNewMenu().then((res) ->
        if res.data.code == 1
          vm.menus.push(res.data.menu)
      )
    vm.setMenu = (menu,index) ->
      params = {
        id: if menu.id then menu.id else null
        type: menu.type
        shop_id: $state.params.id
        title: menu.title
        sub_title: menu.sub_title
        price: menu.price
        sort_no: menu.sort_no
      }
      shopService.getUpdateMenu(params).then((res) ->
        if res.data.code == 1
          vm.menus[index] = res.data.menu
          modalService.error('保存しました。')
      )
    vm.deleteMenu = (menu,index) ->
      if menu.id
        shopService.getDeleteMenu(menu).then((res) ->
          if res.data.code == 1
            vm.menus.splice(index, 1)
            modalService.error('削除しました。')
        )
      else
        vm.menus.splice(index, 1)
    vm.addMenu = ->
      vm.getNewMenu()

    vm.getAdmins = ->
      shopService.getAdmins().then((res) ->
        vm.admins = res.data
      )

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
            options:{aspectRatio: 2 / 1.1,minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true}
          })
        )
        angular.forEach(vm.shop.way_images, (image) ->
          vm.way_images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{aspectRatio: 2 / 1.1,minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true}
          })
        )
        angular.forEach(vm.shop.cards, (card) ->
          vm.visa = true if card.name == 'Visa'
          vm.master = true if card.name == 'Master'
          vm.jcb = true if card.name == 'JCB'
          vm.amex = true if card.name == 'AMEX'
        )
      )
    vm.newShop = ->
      shopService.newShop().then((res) ->
        vm.shop = res.data.shop
        console.log(vm.shop)
        vm.shop["password"] = ''
        vm.images.push({
          id: null
          url: null
          original_url: null
          options:{aspectRatio: 2 / 1.1,minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true}
#          options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,zoomable: true,aspectRatio: "NaN"}
        })
        vm.way_images.push({
          id: null
          url: null
          original_url: null
          options:{aspectRatio: "NaN",minCropBoxWidth:500,minCropBoxHeight:500,zoomable: true}
        })
        angular.forEach(vm.shop.cards, (card) ->
          vm.visa = true if card.name == 'Visa'
          vm.master = true if card.name == 'Master'
          vm.jcb = true if card.name == 'JCB'
          vm.amex = true if card.name == 'AMEX'
        )

      )
    vm.addImage = ->
      vm.images.push({
        id: null
        url: null
        original_url: null
        options:{aspectRatio: 2 / 1.1,minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true}
      })
    vm.addWayImage = ->
      vm.way_images.push({
        id: null
        url: null
        original_url: null
        options:{aspectRatio: "NaN",minCropBoxWidth:500,minCropBoxHeight:500,zoomable: true}
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
      way_images = []
      imageUploaded = $('.image-box--arry2 image-directive img')
      if imageUploaded.length > 0
        $.each(imageUploaded, (index,value)->
          if vm.way_images[index].original_url != vm.way_images[index].url
            if vm.action == 'update'
              way_images.push({id: vm.way_images[index].id, url:vm.way_images[index].url})
            else
              way_images.push(vm.way_images[index].url)
        )
      vm.shop['way_images'] = way_images

      vm.shop['jcb'] = vm.jcb
      vm.shop['master'] = vm.master
      vm.shop['visa'] = vm.visa
      vm.shop['amex'] = vm.amex


      title = "We saved finish "
      buttons = [
        {name:'一覧へ戻る',link:"/admin/shops"}
      ]
      vm.canSubmit = false

      if vm.action == 'update'
        shopService.updateShop(vm.shop).then((res) ->
          if res.data.code == 1
            vm.shop = res.data.shop
            datas = vm.makeDataForModal(vm.shop)
            vm.canSubmit = true
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        shopService.createShop(vm.shop).then((res) ->
          if res.data.code == 1
            vm.shop = res.data.shop
            datas = vm.makeDataForModal(vm.shop)
            vm.canSubmit = true
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
