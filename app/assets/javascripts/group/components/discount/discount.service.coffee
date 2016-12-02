angular.module 'bijyoZukanGroup'
.factory 'discountService', (api) ->
  sm = this

  sm.discounts = ->
    api.getPromise('/api/group/api19',{}).then((res) ->
      return res
    )

  sm.newDiscount = ->
    api.getPromise('/api/group/api20',{}).then((res) ->
      return res
    )

  sm.createDiscount = (opt_params) ->
    api.postPromise('/api/group/api21',opt_params).then((res) ->
      return res
    )

  sm.getDiscount = (opt_id) ->
    api.getPromise('/api/group/api22',{id: opt_id}).then((res) ->
      return res
    )

  sm.updateDiscount = (opt_params) ->
    api.postPromise('/api/group/api23',opt_params).then((res) ->
      return res
    )





  service =
    getSubjects: sm.getSubjects
    getDiscount: sm.getDiscount
    updateDiscount: sm.updateDiscount
    newDiscount: sm.newDiscount
    createDiscount: sm.createDiscount
    discounts: sm.discounts