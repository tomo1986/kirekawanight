angular.module 'bisyoujoZukanNight'
.directive 'contactDirective', ($state,api, modalService,validationService,groupService,customerService) ->
  ContactController = () ->
    vm = this
    vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'CONTACT',link:''}]
    vm.loginCustomer = customerService.getLoginCustomer()
    vm.canContactSubmited = true
    vm.contact = {
      type: 'contact'
      subject_type: 'Contact'
      subject_id: null
      name: if vm.loginCustomer then vm.loginCustomer.name else null
      email: if vm.loginCustomer then vm.loginCustomer.email else null
      tel: if vm.loginCustomer then vm.loginCustomer.tel else null
      message: null
    }
    vm.canContactSubmited = true
    vm.submit = ->
      vm.contactErrors = null
      vm.contactErrors = validationService.checks(vm.contact, groupService.contactValidations)
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0
      vm.canContactSubmited = false
      api.postPromise('/api/front/api6',vm.contact).then((res) ->
        if res.data.code == 1
          vm.canContactSubmited = true
          title = 'お問い合わせを受け付けました。'
          modalService.alert(title,'今しばらくお待ち下さい')
          vm.contact = {
            type: 'contact'
            subject_type: 'Contact'
            subject_id: null
            name: if vm.loginCustomer then vm.loginCustomer.name else null
            email: if vm.loginCustomer then vm.loginCustomer.email else null
            tel: if vm.loginCustomer then vm.loginCustomer.tel else null
            message: null
          }

      )
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ContactController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
