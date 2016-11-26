angular.module 'bijyoZukanAdmin'
.factory 'pickupService', (api) ->
  sm = this
  sm.getSubjects = ->
    api.getPromise('/api/admin/api15',{}).then((res) ->
      return res
    )
  sm.pickups = ->
    api.getPromise('/api/admin/api18',{}).then((res) ->
      return res
    )
  sm.getPickup = (opt_id) ->
    api.getPromise('/api/admin/api23',{id: opt_id}).then((res) ->
      return res
    )
  sm.updatePickup = (opt_params) ->
    api.postPromise('/api/admin/api24',opt_params).then((res) ->
      return res
    )


  sm.newPickup = ->
    api.getPromise('/api/admin/api16',{}).then((res) ->
      return res
    )
  sm.createPickup = (opt_params) ->
    api.postPromise('/api/admin/api17',opt_params).then((res) ->
      return res
    )



  service =
    getSubjects: sm.getSubjects
    getPickup: sm.getPickup
    updatePickup: sm.updatePickup
    newPickup: sm.newPickup
    createPickup: sm.createPickup
    pickups: sm.pickups