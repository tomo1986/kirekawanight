angular.module 'bijyoZukanAdmin'
.directive 'contactFormDirective',  ->
  ContactFormController = (user, contactService, modalService,$state,validationService) ->
    vm = this

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'MAP編集',link:'/business/maps'}]
      vm.imageCropOptions = {zoomable: true,aspectRatio: "NaN"}
      vm.loaded = false

      vm.action = $state.current.action
      if vm.action == 'update'
        vm.getContact()
      else
        vm.breadcrumb.push({name:'MAP新規作成',link:''})

    vm.getContact = ->
      contactService.getContact($state.params.id).then((res) ->
        vm.contact = res.data.contact
      )

    vm.submit = ->
      if vm.action == 'update'
        contactService.updateContact(vm.contact).then((res) ->
          vm.contact = res.data.contact
        )
      else
        contactService.createContact(vm.contact).then((res) ->
          vm.contact = res.data.contact
        )



    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: ContactFormController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
