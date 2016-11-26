angular.module 'bijyoZukanAdmin'
.directive 'resetPasswordDirective',  ->
  ResetPasswordController = ($state,api,user,validationService,modalService) ->
    vm = this
    vm.init = ->
      $state.go '.business_user_sign_in' if $state.current.name == '/login'
      vm.errors = null
      vm.is_finishd = false
      vm.business_user ={ email:null}
      vm.validations = {
        rules:{
          email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
        }
        messages:{
          email:{required: 'Emailを入力してくだだい。',regexp:"Emailが正しくありません。"}
        }
      }
    vm.init()

    vm.submit = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.business_user,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0

      api.postPromise('/api/business_page/api4',vm.business_user).then((res) ->
        if res.data.code == 1
          vm.is_finishd = true
        else
          modalService.error(res.message)
      )
    return
  directive =
    restrict: 'A'
    controller: ResetPasswordController
    controllerAs: 'vm'
    bindToController: true
