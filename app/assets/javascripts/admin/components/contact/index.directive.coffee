angular.module 'bijyoZukanAdmin'
.directive 'contactDirective',  ->
  ContatController = ($state, contactService, modalService) ->
    vm = this
    vm.init = ->
      vm.filters ={
        keyword: null
        group_id: null
        job_type: null
        sex: null
        limit: 5
        page: if $state.params.page then $state.params.page else 1
        ordered: 'id'
      }

      vm.breadcrumb = [{name:'Dashboard',link:'/business'},{name:'contact',link:''}]
      vm.getContacts()

    vm.getContacts = ->
      contactService.getContacts(vm.filters).then((res) ->
        vm.contacts = res.data.contacts
        vm.total = res.data.total
      )
    vm.onPageChanged = (page) ->
      console.log(page)
      $state.go('/contacts',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: ContatController
    controllerAs: 'vm'
    bindToController: true
