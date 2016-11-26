angular.module 'bijyoZukanAdmin'
.directive 'bannerIndexDirective',  ->
  BannerIndexController = ($state, bannerService,modalService) ->
    vm = this
    vm.init = ->
      vm.filter ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'banner list',link:''}]
      vm.getBanners()

    vm.getBanners = ->
      bannerService.getBanners().then((res) ->
        vm.banners = res.data.banners
        vm.total = res.data.total
      )
    vm.init()
    return
  directive =
    restrict: 'A'
    controller: BannerIndexController
    controllerAs: 'vm'
    bindToController: true
