angular.module 'bisyoujoZukanNight'
.directive 'changePasswordDirective', (api, $state,$rootScope,modalService, validationService) ->
  ChangePasswordController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ',link:'/'},{name:'login',link:'/login'},{name:'change password',link:''}]
      vm.loginCustomer ={email: null,password: null,confirmation_password: null}
      vm.validations = {
        rules:{
          email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
        }
        messages:{
          email:{required: 'Emailを入力してくだだい。',regexp:"Emailが正しくありません。"}
        }
      }

    vm.submit = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.loginCustomer,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      api.postPromise('/api/front/change_password',vm.loginCustomer).then((res) ->
        if res.data.code == 1
          window.location.href = "/login"
        else
          modalService.alert('エラー',res.data.message)
      )
    vm.makeNewCustomer = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.newCustomer,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      api.postPromise('/api/front/api9',vm.newCustomer).then((res) ->
        if res.data.code == 1
          window.location.href = if /login/.test($rootScope.history_url) then '/' else $rootScope.history_url
        else
          modalService.alert('エラー',res.data.message)
      )

    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return

  directive =
    restrict: 'A'
    controller: ChangePasswordController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
