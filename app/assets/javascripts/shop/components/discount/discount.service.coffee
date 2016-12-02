angular.module 'bijyoZukanShop'
.factory 'discountService', (api) ->
  sm = this
  sm.discounts = ->
    api.getPromise('/api/shop/api15',{}).then((res) ->
      return res
    )

  sm.newDiscount = ->
    api.getPromise('/api/shop/api16',{}).then((res) ->
      return res
    )
  sm.createDiscount = (opt_params) ->
    api.postPromise('/api/shop/api17',opt_params).then((res) ->
      return res
    )

  sm.getDiscount = (opt_id) ->
    api.getPromise('/api/shop/api18',{id: opt_id}).then((res) ->
      return res
    )
  sm.updateDiscount = (opt_params) ->
    api.postPromise('/api/shop/api19',opt_params).then((res) ->
      return res
    )


  service =
    getSubjects: sm.getSubjects
    getDiscount: sm.getDiscount
    updateDiscount: sm.updateDiscount
    newDiscount: sm.newDiscount
    createDiscount: sm.createDiscount
    discounts: sm.discounts