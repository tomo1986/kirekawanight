angular.module 'bijyoZukanGroup'
.factory 'shopService', (api) ->
  sm = this

  sm.getShops = (opt_filter) ->
    api.getPromise('/api/group/api3', opt_filter).then((res) ->
      return res
    )

  sm.deleteShop = (opt_params) ->
    api.postPromise('/api/group/api4', opt_params).then((res) ->
      return res
    )

  sm.newShop = ->
    api.getPromise('/api/group/api5',{}).then((res) ->
      return res
    )

  sm.createShop = (opt_shop) ->
    api.postPromise('/api/group/api6',opt_shop).then((res) ->
      return res
    )


  sm.getShop = (opt_shop_id) ->
    api.getPromise('/api/group/api7',{id: opt_shop_id}).then((res) ->
      return res
    )

  sm.updateShop = (opt_shop) ->
    api.postPromise('/api/group/api8',opt_shop).then((res) ->
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
      tip:{required: true}
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
      tip:{required: 'tip is required entry'}
      budget_yen:{required: 'min budget yen is required entry'}
      budget_vnd:{required: 'address is required entry'}
      budget_usd:{required: 'address is required entry'}

    }
  }

  sm.getDate = (opt_id) ->
    api.getPromise('/api/group/api9',{id: opt_id}).then((res) ->
      return res
    )
  sm.getContacts = (opt_id) ->
    api.getPromise('/api/group/api10',{id: opt_id}).then((res) ->
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