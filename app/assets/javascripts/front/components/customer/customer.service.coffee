angular.module 'bisyoujoZukanNight'
.factory 'customerService', (api) ->
  sm = this
  sm.loginCustomer = null
  sm.isLogin = -> return Boolean(sm.loginCustomer)
  sm.setLoginCustomer = (opt_customer) ->
    sm.loginCustomer = opt_customer
  sm.getLoginCustomer = ->
    return sm.loginCustomer
  sm.clear = ->
    api.postPromise('/api/front/logout',{}).then((res) ->
      sm.login_user = null
      return true
    )
  sm.update = (params) ->
    api.postPromise('/api/front/api24',params).then((res) ->
      return res
    )

  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      tel:{required: true}
      birthday:{required: true}
    }
    messages:{
      name:{required: '名前を入力してください'}
      tel:{required: '電話番号を入力してください'}
      birthday:{required: '誕生日を入力してください。'}
    }
  }


  service =
    loginCustomer: sm.loginCustomer
    isLogin: sm.isLogin
    setLoginCustomer: sm.setLoginCustomer
    getLoginCustomer: sm.getLoginCustomer
    clear:sm.clear
    update: sm.update
    getValidationRule: sm.getValidationRule
    validations: sm.validations