angular.module 'bijyoZukanShop'
.factory 'shopService', (api) ->
  sm = this
  sm.login_shop = null

  sm.isLogin = -> return Boolean(sm.login_shop)

  sm.setLoginShop = (shop)-> sm.login_shop = shop

  sm.getLoginShop = -> return sm.login_shop

  sm.clear = ->
    api.postPromise('/api/shop/api3',{}).then((res) ->
      sm.login_shop = null
      return true
    )
  sm.loginShop =  ->
    api.getPromise('/api/shop/api2', {}).then((res) ->
      sm.setLoginShop(res.data)
      return res
    )

  sm.getShop = () ->
    api.getPromise('/api/shop/api3',{}).then((res) ->
      return res
    )

  sm.updateShop = (opt_shop) ->
    api.postPromise('/api/shop/api6',opt_shop).then((res) ->
      return res
    )

  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      name_kana:{required: true}
      email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
      job_type:{required: true}
      tel:{required: true}
      address:{required: true}
      is_credit:{required: true}
      chip:{required: true}
      budget_yen:{required: true}
      budget_vnd:{required: true}
      budget_usd:{required: true}
    }
    messages:{
      name:{required: 'name is required entry'}
      name_kana:{required: 'name kana is required entry'}
      email:{required: 'Email is required entry',regexp:"Email format is different "}
      job_type:{required: 'job type is required entry'}
      tel:{required: 'TEL is required entry'}
      address:{required: 'address is required entry'}

      is_credit:{required: 'credit is required entry'}
      chip:{required: 'chip is required entry'}
      budget_yen:{required: 'min budget yen is required entry'}
      budget_vnd:{required: 'address is required entry'}
      budget_usd:{required: 'address is required entry'}

    }
  }

  sm.getDate = ->
    api.getPromise('/api/shop/api5',{}).then((res) ->
      return res
    )
  sm.getContacts = ->
    api.getPromise('/api/shop/api6',{}).then((res) ->
      return res
    )


  service =
    login_shop: sm.login_shop
    isLogin: sm.isLogin
    setLoginShop: sm.setLoginShop
    getLoginShop: sm.getLoginShop
    loginShop: sm.loginShop
    clear: sm.clear
    getShop: sm.getShop
    updateShop: sm.updateShop
    validations : sm.validations
    getValidationRule: sm.getValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts