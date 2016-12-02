angular.module 'bijyoZukanShop'
.directive 'blogDetailDirective',  ->
  BlogDetailController = (blogService, modalService,datePickerService,$state,validationService) ->
    vm = this
    self = vm

    vm.init = ->
      vm.canSubmit = true
      vm.breadcrumb = [{name:'Dashboard',link:'/shop'},{name:'Blog list',link:'/shop/blogs'}]
      vm.active_tab = 'ja'
      vm.images = []
      vm.getBlog()
    vm.getBlog = ->
      blogService.getBlog($state.params.id).then((res) ->
        vm.blog = res.data.blog
        angular.forEach(vm.blog.images, (image) ->
          vm.images.push({
            id: image.id
            url: image.url
            original_url: image.url
            options:{aspectRatio: 1.4 / 2,minCropBoxWidth:336,minCropBoxHeight:481,zoomable: true}
          })
        )
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: BlogDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
