angular.module 'bijyoZukanAdmin'
.directive 'newPasswordDirective',  ->
  NewPasswordController = ($state,api,user,validationService,modalService) ->
    vm = this
    vm.init = ->
      vm.errors = null
      vm.is_finishd = false
      vm.business_user ={ new_password:null,confirm_password: null}
      vm.validations = {
        rules:{
          new_password:{
            required: true
            min: 8
            appraise:{target:'confirm_password'}
          }
          confirm_password:{
            required: true
            min: 8
            appraise:{target:'new_password'}
          }
        }
        messages:{
          new_password:{required: "パスワードを入力してください。",min:'8文字以上入力してくだい',appraise:"パスワードが一致しておりません"}
          confirm_password:{required: "パスワードを入力してください。",min:'8文字以上入力してくだい',appraise:"パスワードが一致しておりません"}
        }
      }
    vm.init()

    vm.submit = ->
      vm.errors = null
      vm.errors = validationService.checks(vm.business_user,vm.validations)
      return window.scrollTo(0, 0) if Object.keys(vm.errors) && Object.keys(vm.errors).length > 0
      params={new_password: vm.business_user.new_password}
      api.postPromise('/api/business_page/api25',params).then((res) ->
        if res.data.code == 1
          vm.is_finishd = true
        else
          modalService.error(res.message)
      )
    return
  directive =
    restrict: 'A'
    controller: NewPasswordController
    controllerAs: 'vm'
    bindToController: true
