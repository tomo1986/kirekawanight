angular.module 'bijyoZukanGroup'
.directive 'groupFormDirective',  ->
  GroupFormController = (groupService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true

      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'Group',link:'/business/maps'}]
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

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getGroup()
      else
        vm.newGroup()
        vm.breadcrumb.push({name:'MAP新規作成',link:''})
    vm.getGroup = ->
      groupService.getGroup($state.params.id).then((res) ->
        vm.group = res.data.group
        angular.forEach(vm.group.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{minCropBoxWidth:1920,minCropBoxHeight:1026,zoomable: true,aspectRatio:"NaN"}
          })
        )
      )

    vm.newGroup = ->
      groupService.newGroup().then((res) ->
        vm.group = res.data.group
        vm.group["password"] = ''
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
      vm.errors = validationService.checks(vm.group,groupService.getValidationRule())
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
      vm.group['images'] = images
      title = "We saved finish "
      buttons = [
        {name:'一覧へ戻る',link:"/group/groups"}
        {name:'新しいカプセル追加',link:"/group/groups/new",callbackFunc: vm.init}
      ]

      if vm.action == 'update'
        groupService.updateGroup(vm.group).then((res) ->
          if res.data.status == 1
            vm.group = res.data.group
            datas = vm.makeDataForModal(vm.group)
            console.log(title,datas,buttons)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )
      else
        groupService.createGroup(vm.group).then((res) ->
          if res.data.status == 1
            vm.group = res.data.group
            datas = vm.makeDataForModal(vm.group)
            modalService.confirm(title,datas,buttons)
          else
            modalService.error(res.data.errors)
        )


    vm.makeDataForModal = (group)->
      return [
        {name:"name", val: group.name, kind:"string"}
        {name:"name_kana", val: group.name_kana, kind:"string"}
        {name:"tel", val: group.tel, kind:"string"}
        {name:"email", val:group.email, kind:"string"}
        {name:"job_type", val:group.job_type, kind:"string"}
        {name:"address", val:group.address, kind:"string"}
        {name:"is_credit", val:group.is_credit, kind:"string"}
        {name:"is_smoked", val:group.is_smoked, kind:"string"}
        {name:"chip", val:group.chip, kind:"string"}
        {name:"budget_usd", val:group.budget_usd, kind:"number"}
        {name:"budget_vnd", val:group.budget_vnd, kind:"number"}
        {name:"budget_usd", val:group.budget_usd, kind:"number"}
        {name:"opened_at", val:group.opened_at, kind:"date"}
        {name:"closed_at", val:group.closed_at, kind:"number"}
        {name:"interview(japanese)", val:group.interview_ja, kind:"text"}
      ]

    vm.onReady = ->
      vm.loaded = true
      return

    vm.onChangeTab = (opt_tab) ->
      vm.active_tab = opt_tab

    vm.callbackGetLocationAddress = (ido,keido,address) ->
      vm.group.lon = parseFloat(ido)
      vm.group.lat = parseFloat(keido)
      vm.group.address = address

    vm.getAddressFromMap = () ->
      position = {
        location: [vm.group.lon,vm.group.lat]
        address: vm.group.address
      }
      modalService.getAddress(position, vm.callbackGetLocationAddress)


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: GroupFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
