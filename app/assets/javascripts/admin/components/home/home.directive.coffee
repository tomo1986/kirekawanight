angular.module 'bijyoZukanAdmin'
.directive 'homeDirective',  ->
  HomeController = (modalService, $scope, api) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'}]
      vm.download_capsule_count = null
      vm.capsule_count = null
      vm.map_view_count = null
      vm.log_actions = null
      vm.chartLineOptions = {
        padding:{top: 10,right: 10,bottom: 20,left: 10}
        showY:true
        showX:true
        legend:true
        tooltip:true
        height:'100px'
        chartColor:'#fff'
      }

      vm.getDatas()
      vm.getCharts()

    vm.getDatas = () ->
      api.getPromise('/api/admin/api56',{}).then((res) ->
        if res.data.code == 1
          vm.reviews = res.data.reviews
          vm.contacts = res.data.contacts
          vm.shop_count = res.data.shop_count
          vm.user_count = res.data.user_count
          vm.todays_review_count = res.data.todays_review_count
          vm.todays_contact_count = res.data.todays_contact_count
          vm.last_month_review_count = res.data.last_month_review_count
          vm.last_month_contact_count = res.data.last_month_contact_count
        else
          modalService.error(res.data.message)
      )

    vm.getCharts = () ->
      api.getPromise('/api/admin/api66',{}).then((res) ->
        console.log(res)
        if res.data.code == 1
          vm.chartLine1 = res.data.chart_date
        else
          modalService.error(res.data.message)
      )


    vm.onCancelButtonClicked = (review) ->
      api.postPromise('/api/admin/api73',review).then((res) ->
        if res.data.code == 1
          vm.reviews = res.data.reviews
        else
          modalService.error(res.data.message)
      )


    vm.onClickDisplayed = (review) ->

      api.postPromise('/api/admin/api57',review).then((res) ->
        if res.data.code == 1
          vm.reviews = res.data.reviews
        else
          modalService.error(res.data.message)
      )


    vm.init()
    return
  directive =
    restrict: 'A'
    controller: HomeController
    controllerAs: 'vm'
    bindToController: true
