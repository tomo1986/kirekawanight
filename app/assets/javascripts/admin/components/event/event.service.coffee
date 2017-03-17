angular.module 'bijyoZukanAdmin'
.factory 'eventService', (api) ->
  sm = this

  sm.events = ->
    api.getPromise('/api/admin/api83',{}).then((res) ->
      return res
    )

  sm.newEvent = ->
    api.getPromise('/api/admin/api84',{}).then((res) ->
      return res
    )
  sm.createEvent = (opt_params) ->
    api.postPromise('/api/admin/api85',opt_params).then((res) ->
      return res
    )

  sm.getEvent = (opt_id) ->
    api.getPromise('/api/admin/api86',{id: opt_id}).then((res) ->
      return res
    )
  sm.updateEvent = (opt_params) ->
    api.postPromise('/api/admin/api87',opt_params).then((res) ->
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
    getEvent: sm.getEvent
    updateEvent: sm.updateEvent
    newEvent: sm.newEvent
    createEvent: sm.createEvent
    events: sm.events
    getAllUsers: sm.getAllUsers
    getAllShops: sm.getAllShops