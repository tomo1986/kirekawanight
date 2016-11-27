angular.module 'bijyoZukanGroup'
.factory 'groupService', (api) ->
  sm = this
  sm.login_group = null

  sm.isLogin = -> return Boolean(sm.login_group)

  sm.setLoginGroup = (group)-> sm.login_group = group

  sm.getLoginGroup = -> return sm.login_group

  sm.clear = ->
    api.postPromise('/api/group/api3',{}).then((res) ->
      sm.login_group = null
      return true
    )
  sm.loginGroup =  ->
    api.getPromise('/api/group/api2', {}).then((res) ->
      sm.setLoginGroup(res.data)
      return res
    )

  sm.newGroup = ->
    api.getPromise('/api/group/api3',{}).then((res) ->
      return res
    )
  sm.getGroup = (opt_group_id) ->
    api.getPromise('/api/group/api5',{id: opt_group_id}).then((res) ->
      return res
    )
  sm.createGroup = (opt_group) ->
    api.postPromise('/api/group/api4',opt_group).then((res) ->
      return res
    )
  sm.updateGroup = (opt_group) ->
    api.postPromise('/api/group/api6',opt_group).then((res) ->
      return res
    )

  sm.getGroups = (opt_filter) ->
    api.getPromise('/api/group/api2', opt_filter).then((res) ->
      return res
    )
  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      name_kana:{required: true}
      email:{required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
      job_type:{required: true}
      tel:{required: true}
      address:{required: true}
      is_credit:{required: true}
      chip:{required: true}
      budget_yen:{required: true}
      budget_vnd:{required: true}
      budget_usd:{required: true}
    }
    messages:{
      name:{required: 'name is required entry'}
      name_kana:{required: 'name kana is required entry'}
      email:{required: 'Email is required entry',regexp:"Email format is different "}
      job_type:{required: 'job type is required entry'}
      tel:{required: 'TEL is required entry'}
      address:{required: 'address is required entry'}

      is_credit:{required: 'credit is required entry'}
      chip:{required: 'chip is required entry'}
      budget_yen:{required: 'min budget yen is required entry'}
      budget_vnd:{required: 'address is required entry'}
      budget_usd:{required: 'address is required entry'}

    }
  }

  sm.getDate = (opt_id) ->
    api.getPromise('/api/group/api41',{id: opt_id}).then((res) ->
      return res
    )
  sm.getContacts = (opt_id) ->
    api.getPromise('/api/group/api43',{id: opt_id}).then((res) ->
      return res
    )


  service =
    login_group: sm.login_group
    isLogin: sm.isLogin
    setLoginGroup: sm.setLoginGroup
    getLoginGroup: sm.getLoginGroup
    loginGroup: sm.loginGroup
    clear: sm.clear
    newGroup: sm.newGroup
    getGroup: sm.getGroup
    createGroup: sm.createGroup
    getGroups: sm.getGroups
    updateGroup: sm.updateGroup
    validations : sm.validations
    getValidationRule: sm.getValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts