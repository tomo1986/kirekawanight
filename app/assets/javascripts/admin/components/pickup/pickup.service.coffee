angular.module 'bijyoZukanAdmin'
.factory 'pickupService', (api) ->
  sm = this

  sm.pickups = ->
    api.getPromise('/api/admin/api19',{}).then((res) ->
      return res
    )

  sm.newPickup = ->
    api.getPromise('/api/admin/api20',{}).then((res) ->
      return res
    )
  sm.createPickup = (opt_params) ->
    api.postPromise('/api/admin/api21',opt_params).then((res) ->
      return res
    )

  sm.getPickup = (opt_id) ->
    api.getPromise('/api/admin/api22',{id: opt_id}).then((res) ->
      return res
    )
  sm.updatePickup = (opt_params) ->
    api.postPromise('/api/admin/api23',opt_params).then((res) ->
      return res
    )

  sm.getAllUsers = ->
    api.getPromise('/api/admin/all_users',{}).then((res) ->
      return res
    )
  sm.getAllShops = ->
    api.getPromise('/api/admin/all_shops',{}).then((res) ->
      return res
    )


  service =
    getPickup: sm.getPickup
    updatePickup: sm.updatePickup
    newPickup: sm.newPickup
    createPickup: sm.createPickup
    pickups: sm.pickups
    getAllUsers: sm.getAllUsers
    getAllShops: sm.getAllShops