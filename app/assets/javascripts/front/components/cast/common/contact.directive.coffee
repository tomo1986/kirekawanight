angular.module 'bisyoujoZukanNight'
.directive 'castDetailContactDirective', (castService, modalService, customerService, $state) ->
  CastDetailContactController = () ->
    vm = this
    vm.init = ->
      vm.canContactSubmited = true
      vm.contact = {
        type: 'user_detail'
        subject_type: 'User'
        subject_id: $state.params.id
        return_way: 'email'
        name: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.name else null
        email: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.email else null
        tel: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.tel else null
        reservation_date: null
        message: null
      }

    vm.contactSubmit = ->
      vm.contactErrors = {}
      vm.contactErrors['name'] = '氏名を入力してくだい。' if !vm.contact.name
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0
      console.log()
      message = ''
      message = message + "Customer Name： #{vm.contact.name}\n"
      message = message + "Email： #{vm.contact.email}\n"
      message = message + "選択した女の子#{vm.parentCtrl.cast.name}"
      message = message + "\n\n"
      vm.contact.message = message + vm.contact.message
      vm.canContactSubmited = false

      castService.sendContact(vm.contact).then((res) ->
        vm.canContactSubmited = true
        title = '受け付けました。'
        message = '回答を授時行っております。今しばらくお待ちください。'
        modalService.alert(title,message)
        vm.contact = {
          type: 'user_detail'
          subject_type: 'User'
          subject_id: $state.params.id
          return_way: 'email'
          name: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.name else null
          email: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.email else null
          tel: if vm.parentCtrl.loginCustomer then vm.parentCtrl.loginCustomer.tel else null
          message: ''
        }
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
    controller: CastDetailContactController
    controllerAs: 'vm'
    link: linkFunc
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/casts/common/_contact.html"
    bindToController: true

