angular.module 'bisyoujoZukanNight'
.directive 'contactDirective', ($state, modalService,validationService,groupService,customerService) ->
  ContactController = () ->
    vm = this
    vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'CONTACT',link:''}]
    vm.loginCustomer = customerService.getLoginCustomer()
    vm.canContactSubmited = true
    vm.contact = {
      type: if $state.params && $state.params.type then $state.params.type else null
      name: if vm.loginCustomer then vm.loginCustomer.name else null
      email: if vm.loginCustomer then vm.loginCustomer.email else null
      subject_type: null
      subject_id: null
      tel: null
      message: null
    }
    vm.submit = ->
      console.log("soeya")
      vm.contactErrors = null
      vm.contactErrors = validationService.checks(vm.contact, groupService.contactValidations)
      return if Object.keys(vm.contactErrors) && Object.keys(vm.contactErrors).length > 0

      title = 'お問い合わせを受け付けました。'

      datas = [
        {name:"アカウント名",val:vm.contact.name,kind:"string"}
        {name:"メールアドレス",val:vm.contact.email,kind:"string"}
        {name:"メールアドレス",val:vm.contact.message,kind:"text"}
      ]
      modalService.confirm(title,datas)

    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: ContactController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
