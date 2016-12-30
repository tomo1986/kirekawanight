angular.module 'bijyoZukanAdmin'
.factory 'shopService', (api) ->
  sm = this

  sm.getShops = (opt_filter) ->
    api.getPromise('/api/admin/api50', opt_filter).then((res) ->
      return res
    )
  sm.newShop = ->
    api.getPromise('/api/admin/api51',{}).then((res) ->
      return res
    )

  sm.createShop = (opt_shop) ->
    api.postPromise('/api/admin/api52',opt_shop).then((res) ->
      return res
    )

  sm.getShop = (opt_shop_id) ->
    api.getPromise('/api/admin/api53',{id: opt_shop_id}).then((res) ->
      return res
    )
  sm.updateShop = (opt_shop) ->
    api.postPromise('/api/admin/api54',opt_shop).then((res) ->
      return res
    )

  sm.deleteShop = (opt_prams) ->
    api.postPromise('/api/admin/api55',opt_prams).then((res) ->
      return res
    )
  sm.getAdmins = ->
    api.getPromise('/api/admin/all_admins',{}).then((res) ->
      return res
    )

  sm.getGroups = ->
    api.getPromise('/api/admin/all_groups',{}).then((res) ->
      return res
    )

  sm.allGetShops = ->
    api.getPromise('/api/admin/all_shops',{}).then((res) ->
      return res
    )

  sm.getTags = ->
    api.getPromise('/api/admin/all_tags',{}).then((res) ->
      return res
    )



  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      name_kana:{required: true}
      email:{required: true,regexp:/^\w+([\.-\.+]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/i}
      job_type:{required: true}
      tel:{required: true}
      is_credit:{required: true}
      chip:{required: true}
      budget_yen:{required: true,regexp:/^[0-9]+$/}
      budget_vnd:{required: trueregexp:/^[0-9]+$/}
      budget_usd:{required: trueregexp:/^[0-9]+$/}
    }
    messages:{
      name:{required: '名前は必須です。'}
      name_kana:{required: '名前(カナ)は必須です。'}
      email:{required: 'メールアドレスは必須です。',regexp:"Email format is different "}
      job_type:{required: 'job type is required entry'}
      tel:{required: 'TEL is required entry'}
      is_credit:{required: 'credit is required entry'}
      chip:{required: 'chip is required entry'}
      budget_yen:{required: 'min budget yen is required entry',regexp:'半角数字のみ'}
      budget_vnd:{required: 'address is required entry',regexp:'半角数字のみ'}
      budget_usd:{required: 'address is required entry',regexp:'半角数字のみ'}

    }
  }

  sm.getDate = (opt_id) ->
    api.getPromise('/api/admin/api41',{id: opt_id}).then((res) ->
      return res
    )
  sm.getContacts = (opt_id) ->
    api.getPromise('/api/admin/api43',{id: opt_id}).then((res) ->
      return res
    )


  service =
    newShop: sm.newShop
    getShop: sm.getShop
    createShop: sm.createShop
    getShops: sm.getShops
    updateShop: sm.updateShop
    validations : sm.validations
    getValidationRule: sm.getValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts
    deleteShop: sm.deleteShop
    getTags: sm.getTags
    getAdmins: sm.getAdmins
    getGroups: sm.getGroups
    allGetShops: sm.allGetShops