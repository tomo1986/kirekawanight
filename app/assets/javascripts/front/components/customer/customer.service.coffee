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


  service =
    loginCustomer: sm.loginCustomer
    isLogin: sm.isLogin
    setLoginCustomer: sm.setLoginCustomer
    getLoginCustomer: sm.getLoginCustomer
    clear:sm.clear