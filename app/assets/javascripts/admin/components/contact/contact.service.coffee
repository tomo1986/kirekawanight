angular.module 'bijyoZukanAdmin'
.factory 'contactService', (api) ->
  sm = this

  sm.getContacts = (opt_params)->
    api.getPromise('/api/admin/api14',opt_params).then((res) ->
      return res
    )

  sm.newContact = () ->
    api.getPromise('/api/admin/api15',{id: opt_id}).then((res) ->
      return res
    )

  sm.createContact = (opt_params) ->
    api.postPromise('/api/admin/api16',opt_params).then((res) ->
      return res
    )


  sm.getContact = (opt_id) ->
    api.getPromise('/api/admin/api17',{id: opt_id}).then((res) ->
      return res
    )

  sm.updateContact = (opt_params) ->
    api.postPromise('/api/admin/api18',opt_params).then((res) ->
      return res
    )

  service =
    getContacts: sm.getContacts
    newContact: sm.newContact
    getContact: sm.getContact
    createContact: sm.createContact
    updateContact: sm.updateContact
