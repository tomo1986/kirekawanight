angular.module 'bisyoujoZukanNight'
.directive 'shopDetailContactDirective', (shopService, modalService, customerService, $state) ->
  ShopDetailContactController = () ->
    vm = this
    vm.init = ->
      vm.canContactSubmited = true
      vm.casts = []
      vm.reservationDate={
        from:{is_from:true,date:null}
        enable_time: true
        format: 'yyyy-MM-dd HH:mm'
        is_required:true
        placeholder:'必須'
      }

      vm.contactData = {
        contact_type: 'reservation'
        peoples: null
        selectCasts:[{image:null,title: "選択してください",isOpened:false}]
        reservation_date: null
      }

      vm.contact = {
        type: 'shop_detail'
        subject_type: 'Shop'
        subject_id: $state.params.id
        return_way: 'email'
        name: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.name else null
        email: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.email else null
        tel: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.tel else null
        reservation_date: null
        message: null
      }
      vm.getCasts()
    vm.getCasts = ->
      shopService.getAllCasts({id: vm.parentCtrl.pageId}).then((res) ->
        if res.data.code == 1
          angular.forEach(res.data.users, (cast) ->
            vm.casts.push(cast)
          )
      )

    vm.contactSubmit = ->
      vm.contactErrors = {}
      vm.contactErrors['name'] = '氏名を入力してくだい。' if !vm.contact.name
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0
      console.log(vm.contactData)
      message = ''
      message = message + "Customer Name： #{vm.contact.name}\n"
      message = message + "Email： #{vm.contact.email}\n"
      if vm.contactData.contact_type == 'reservation'
        message = message + "number of reservable：　#{vm.contactData.peoples}peaples\n"
        message = message + "reservation time：　#{vm.contactData.reservation_date}\n"
        message = message + "reservation casts\n"
        angular.forEach(vm.contactData.selectCasts, (cast) ->
          message = message + "#{cast.title}\n"
        )
        message = message + "\n\n"
      vm.contact.message = message + vm.contact.message
      vm.canContactSubmited = false

      shopService.sendContact(vm.contact).then((res) ->
        vm.canContactSubmited = true
        title = '受け付けました。'
        message = '回答を授時行っております。今しばらくお待ちください。'
        modalService.alert(title,message)
        vm.contact = {
          type: 'shop_detail'
          subject_type: 'Shop'
          subject_id: $state.params.id
          return_way: 'email'
          name: if vm.loginCustomer then vm.loginCustomer.name else null
          email: if vm.loginCustomer then vm.loginCustomer.email else null
          tel: if vm.loginCustomer then vm.loginCustomer.tel else null
          message: 'そのほか'
        }
      )
    vm.onSelectCast = (cast) ->
      vm.selectCastNow = cast
      url = if cast.images[0] then cast.images[0].url else null
      vm.contactData.selectCasts[vm.selectDropDownNo] = {
        image:url,title:"Cast.No#{cast.id}/#{cast.name}",isOpened: false
      }


    vm.onClickDropDown = (cast, index) ->
      vm.selectDropDownNo = index
      vm.contactData.selectCasts[vm.selectDropDownNo].isOpened = !cast.isOpened

    vm.onAdd = ->
      vm.contactData.selectCasts[vm.selectDropDownNo].isOpened = false
      vm.selectDropDownNo = null
      vm.contactData.selectCasts.push({image:null,title: "選択してください",isOpened:false})
      vm.selectCasts.push(vm.selectCastNow)
      angular.forEach(vm.casts, (val, index) ->
        vm.casts.splice(index, 1) if val.id == vm.selectCastNow.id
      )


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'E'
    scope:{
      parentCtrl: "="
    }
    controller: ShopDetailContactController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/shops/common/_contact.html"
    bindToController: true

