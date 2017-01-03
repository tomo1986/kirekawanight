angular.module 'bisyoujoZukanNight'
.directive 'shopDetailContactDirective', (shopService, modalService, customerService, $state) ->
  ShopDetailContactController = () ->
    vm = this
    vm.init = ->
      vm.canContactSubmited = true
      vm.casts = []
      vm.castIds = []
      vm.selectCasts ={}

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
        selectCasts:[{id:null,image:null,title: "選択してください",isOpened:false,canAdded:true}]
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
      message = ''
      message = message + "氏名： #{vm.contact.name}\n"
      message = message + "Emailアドレス： #{vm.contact.email}\n"
      message = message + "電話番号： #{vm.contact.tel}\n"
      if vm.contactData.contact_type == 'reservation'
        message = message + "予約人数：　#{vm.contactData.peoples}peaples\n"
        message = message + "予約時間：　#{vm.contactData.reservation_date}\n"
        message = message + "============ 予約キャスト ============\n"
        angular.forEach(vm.selectCasts, (val,key) ->
          message = message + "Cast No.#{val.id} #{val.name}\n"
        )
        message = message + "============ 予約キャスト ============\n"
        message = message + "\n\n"
      params = {
        type: 'shop_detail'
        subject_type: 'Shop'
        subject_id: $state.params.id
        name: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.name else null
        email: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.email else null
        tel: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.tel else null
        message: if vm.contact.message then message + vm.contact.message else message
      }
      vm.canContactSubmited = false

      shopService.sendContact(params).then((res) ->
        vm.canContactSubmited = true
        title = '受け付けました。'
        message = '回答を授時行っております。今しばらくお待ちください。'
        modalService.alert(title,message)
        vm.contact = {
          type: 'shop_detail'
          subject_type: 'Shop'
          subject_id: $state.params.id
          return_way: 'email'
          name: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.name else null
          email: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.email else null
          tel: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.tel else null
          message: ''
        }
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
          selectCasts:[{id:null,image:null,title: "選択してください",isOpened:false,canAdded:true}]
          reservation_date: null
        }

      )
    vm.onClickCastModal = () ->
      modalService.modalSelectCasts(vm.casts,vm.selectCasts,vm.callbackselectCasts)

    vm.callbackselectCasts = (casts) ->
      vm.selectCasts = casts


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

