angular.module 'bijyoZukanShop'
.directive 'blogIndexDirective',  ->
  BlogIndexController = ($state, blogService,modalService) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'},{name:'Blog List',link:''}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.getBlogs()

    vm.getBlogs = ->
      blogService.getBlogs(vm.filter).then((res) ->
        vm.blogs = res.data.blogs
        window.scrollTo(0, 0)
      )

    vm.executeDeletion = () ->
      mapService.deleteMap(vm.delete_map_id).then((res) ->
        if res.code == 1
          modalService.alert('削除しました。')
          vm.getMaps()
        else
          modalService.error(res.data.message)
      )

    vm.pageChanged = (page) ->
      $state.go('/maps',{page:page})
      return

    vm.init()
    return
  directive =
    restrict: 'A'
    controller: BlogIndexController
    controllerAs: 'vm'
    bindToController: true
