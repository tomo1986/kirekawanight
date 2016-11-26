angular.module 'bisyoujoZukanNight'
.factory 'groupService', (api) ->
  sm = this
  sm.getGroupList = (opt_jobType) ->
    api.getPromise('/api/front/api12',opt_jobType).then((res) ->
      return res
    )
  sm.pushPost = (opt_params) ->
    api.postPromise('/api/front/api5',opt_params).then((res) ->
      return res
    )
  sm.getGroup = (opt_group_id) ->
    api.getPromise('/api/front/api4',{id: opt_group_id}).then((res) ->
      return res
    )
  sm.sendContact = (opt_params) ->
    api.postPromise('/api/front/api6',opt_params).then((res) ->
      return res
    )
  sm.sendReview = (opt_params) ->
    api.postPromise('/api/front/api13',opt_params).then((res) ->
      return res
    )

  sm.contactValidations = {
    rules: {
      name: {required: true}
      email: {required: true,regexp:/(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/}
      tel: {required: true}
      message: {required: true}
    }
    messages: {
      name: {required: '氏名が入力されていません。'}
      email: {required: 'emailが入力されていません。',regexp:"Emailが正しくありません。"}
      tel: {required: 'telが入力されていません。'}
      message: {required: 'コンテンツが入力されていません。'}
    }
  }
  sm.reviewValidations = {
    rules: {
      service_score: {required: true}
      serving_score: {required: true}
      girl_score: {required: true}
      ambience_score: {required: true}
      again_score: {required: true}
      comment: {required: true}
    }
    messages: {
      service_score: {required: '氏名が入力されていません。'}
      serving_score: {required: 'emailが入力されていません。',regexp:"Emailが正しくありません。"}
      girl_score: {required: 'telが入力されていません。'}
      ambience_score: {required: 'telが入力されていません。'}
      again_score: {required: 'コンテンツが入力されていません。'}
      comment: {required: 'コンテンツが入力されていません。'}
    }
  }

  service =
    getGroupList: sm.getGroupList
    pushPost: sm.pushPost
    getGroup: sm.getGroup
    sendContact: sm.sendContact
    sendReview: sm.sendReview
    contactValidations: sm.contactValidations
    reviewValidations: sm.reviewValidations
