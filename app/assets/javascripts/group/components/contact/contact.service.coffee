angular.module 'bijyoZukanGroup'
.factory 'contactService', (api) ->
  sm = this
  sm.getContacts = (opt_params)->
    api.getPromise('/api/group/api12',opt_params).then((res) ->
      return res
    )
  sm.getContact = (opt_id) ->
    api.getPromise('/api/group/api21',{id: opt_id}).then((res) ->
      return res
    )

  sm.createContact = (opt_params) ->
    api.postPromise('/api/group/api20',opt_params).then((res) ->
      return res
    )

  sm.updateContact = (opt_params) ->
    api.postPromise('/api/group/api22',opt_params).then((res) ->
      return res
    )

  service =
    getContacts: sm.getContacts
    getContact: sm.getContact
    createContact: sm.createContact
    updateContact: sm.updateContact
