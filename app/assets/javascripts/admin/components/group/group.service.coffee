angular.module 'bijyoZukanAdmin'
.factory 'groupService', (api) ->
  sm = this

  sm.getGroups = (opt_filter) ->
    api.getPromise('/api/admin/api2', opt_filter).then((res) ->
      return res
    )
  sm.newGroup = ->
    api.getPromise('/api/admin/api3',{}).then((res) ->
      return res
    )

  sm.createGroup = (opt_group) ->
    api.postPromise('/api/admin/api4',opt_group).then((res) ->
      return res
    )

  sm.getGroup = (opt_group_id) ->
    api.getPromise('/api/admin/api5',{id: opt_group_id}).then((res) ->
      return res
    )
  sm.updateGroup = (opt_group) ->
    api.postPromise('/api/admin/api6',opt_group).then((res) ->
      return res
    )

  sm.deleteGroup = (opt_prams) ->
    api.postPromise('/api/admin/api7',opt_prams).then((res) ->
      return res
    )

  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      name_kana:{required: true}
      email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
      address:{required: true}
    }
    messages:{
      name:{required: 'name is required entry'}
      name_kana:{required: 'name kana is required entry'}
      email:{required: 'Email is required entry',regexp:"Email format is different "}
      address:{required: 'address is required entry'}
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
    newGroup: sm.newGroup
    getGroup: sm.getGroup
    createGroup: sm.createGroup
    getGroups: sm.getGroups
    updateGroup: sm.updateGroup
    validations : sm.validations
    getValidationRule: sm.getValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts
    deleteGroup: sm.deleteGroup