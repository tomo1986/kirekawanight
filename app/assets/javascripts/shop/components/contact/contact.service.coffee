angular.module 'bijyoZukanShop'
.factory 'contactService', (api) ->
  sm = this
  sm.getContacts = (opt_params)->
    api.getPromise('/api/shop/api12',opt_params).then((res) ->
      return res
    )
  sm.getContact = (opt_id) ->
    api.getPromise('/api/shop/api21',{id: opt_id}).then((res) ->
      return res
    )

  sm.createContact = (opt_params) ->
    api.postPromise('/api/shop/api20',opt_params).then((res) ->
      return res
    )

  sm.updateContact = (opt_params) ->
    api.postPromise('/api/shop/api22',opt_params).then((res) ->
      return res
    )

  service =
    getContacts: sm.getContacts
    getContact: sm.getContact
    createContact: sm.createContact
    updateContact: sm.updateContact
