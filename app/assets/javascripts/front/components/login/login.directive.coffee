angular.module 'bisyoujoZukanNight'
.directive 'loginDirective', (api, $state,$rootScope,modalService, validationService) ->
  LoginController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'login',link:'/'}]
      vm.loginCustomer ={email: null,password: null}
      vm.newCustomer ={email: null,password: null}
      vm.validations = {
        rules:{
          email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
          password:{required: true}
        }
        messages:{
          email:{required: 'Emailを入力してくだだい。',regexp:"Emailが正しくありません。"}
          password:{required: 'パスワードを入力してください。'}
        }
      }

    vm.submit = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.loginCustomer,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      api.postPromise('/api/front/api10',vm.loginCustomer).then((res) ->
        console.log(res)
        if res.code == 1
          window.location.reload()
        else
          modalService.alert('エラー',res.data.message)
      )
    vm.makeNewCustomer = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.newCustomer,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      api.postPromise('/api/front/api14',vm.newCustomer).then((res) ->
        if res.code == 1
          window.location.reload()
        else
          modalService.alert('エラー',res.data.message)
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
