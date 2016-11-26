angular.module 'bijyoZukanAdmin'
.directive 'loginDirective',  ->
  LoginController = ($state,api,user,validationService,modalService) ->
    vm = this
    vm.init = ->
      vm.height = window.parent.screen.height
      vm.errors = null
      vm.user ={ email:null, password:null,remember_me:null}
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
    vm.init()
    vm.submit = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.user,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0
      api.postPromise('/api/admin/api1',vm.user).then((res) ->
        if res.data.code == 1
          user.setLoginUser(res.data.data)
          window.location.reload()
        else
          modalService.error(res.data.message)
      )
    return
  directive =
    restrict: 'A'
    controller: LoginController
    controllerAs: 'vm'
    bindToController: true
