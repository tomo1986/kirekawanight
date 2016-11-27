angular.module 'bijyoZukanGroup'
.factory 'pickupService', (api) ->
  sm = this
  sm.getSubjects = ->
    api.getPromise('/api/group/api15',{}).then((res) ->
      return res
    )
  sm.pickups = ->
    api.getPromise('/api/group/api18',{}).then((res) ->
      return res
    )
  sm.getPickup = (opt_id) ->
    api.getPromise('/api/group/api23',{id: opt_id}).then((res) ->
      return res
    )
  sm.updatePickup = (opt_params) ->
    api.postPromise('/api/group/api24',opt_params).then((res) ->
      return res
    )


  sm.newPickup = ->
    api.getPromise('/api/group/api16',{}).then((res) ->
      return res
    )
  sm.createPickup = (opt_params) ->
    api.postPromise('/api/group/api17',opt_params).then((res) ->
      return res
    )



  service =
    getSubjects: sm.getSubjects
    getPickup: sm.getPickup
    updatePickup: sm.updatePickup
    newPickup: sm.newPickup
    createPickup: sm.createPickup
    pickups: sm.pickups