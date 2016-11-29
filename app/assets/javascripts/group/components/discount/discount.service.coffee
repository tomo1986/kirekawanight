angular.module 'bijyoZukanGroup'
.factory 'discountService', (api) ->
  sm = this
  sm.getSubjects = ->
    api.getPromise('/api/group/api15',{}).then((res) ->
      return res
    )
  sm.discounts = ->
    api.getPromise('/api/group/api18',{}).then((res) ->
      return res
    )
  sm.getDiscount = (opt_id) ->
    api.getPromise('/api/group/api23',{id: opt_id}).then((res) ->
      return res
    )
  sm.updateDiscount = (opt_params) ->
    api.postPromise('/api/group/api24',opt_params).then((res) ->
      return res
    )


  sm.newDiscount = ->
    api.getPromise('/api/group/api45',{}).then((res) ->
      return res
    )
  sm.createDiscount = (opt_params) ->
    api.postPromise('/api/group/api46',opt_params).then((res) ->
      return res
    )



  service =
    getSubjects: sm.getSubjects
    getDiscount: sm.getDiscount
    updateDiscount: sm.updateDiscount
    newDiscount: sm.newDiscount
    createDiscount: sm.createDiscount
    discounts: sm.discounts