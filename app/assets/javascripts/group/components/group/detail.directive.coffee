angular.module 'bijyoZukanGroup'
.directive 'groupDetailDirective',  ->
  GroupDetailController = (groupService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/group'},{name:'Group list',link:'/group/groups'}]
      vm.active_tab = 'ja'
      vm.chartLineOptions = {
        padding:{top: 10,right: 10,bottom: 20,left: 10}
        showY:true
        showX:true
        legend:true
        tooltip:true
        height:'100px'
        chartColor:'#fff'
      }

      vm.getGroup()
      vm.getDate()
      vm.getContacts()

    vm.getDate = ->
      groupService.getDate($state.params.id).then((res) ->
        vm.chartLine1 = res.data.chart_date
        vm.monthly_contact_count = res.data.monthly_contact_count
        vm.monthly_favorite_count = res.data.monthly_favorite_count
        vm.monthly_pv_count = res.data.monthly_pv_count
        vm.monthly_support_count = res.data.monthly_support_count
        vm.monthly_review_count = res.data.monthly_review_count
      )
    vm.getContacts = ->
      groupService.getContacts($state.params.id).then((res) ->
        vm.contacts = res.data.contacts
        vm.reviews = res.data.reviews
      )



    vm.getGroup = ->
      groupService.getGroup($state.params.id).then((res) ->
        vm.group = res.data.group
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: GroupDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
