angular.module 'bisyoujoZukanNight'
.directive 'loginDirective', (api, $state,$rootScope,modalService) ->
  LoginController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'kire kawa',link:'/'},{name:'login',link:'/'}]
      vm.customer ={email: null,password: null}

    vm.submit = ->
      console.log("aaa")
      api.postPromise('/api/front/api10',vm.customer).then((res) ->
        window.location.reload()
      )
    vm.makeNewCustomer = ->
      buttons = [{name:'詳細登録',link:'/customers/form'},{name:'トップへ戻る',link:'/'}]
      title = '登録しました。'
      api.postPromise('/api/front/api14',vm.customer).then((res) ->
        modalService.confirm(title,[],buttons)
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: LoginController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
