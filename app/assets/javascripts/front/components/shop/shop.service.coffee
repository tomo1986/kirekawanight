angular.module 'bisyoujoZukanNight'
.factory 'shopService', (api) ->
  sm = this

  sm.getShopList = (opt_jobType) ->
    api.getPromise('/api/front/api12',opt_jobType).then((res) ->
      return res
    )
  sm.pushPost = (opt_params) ->
    api.postPromise('/api/front/api5',opt_params).then((res) ->
      return res
    )
  sm.getShop = (opt_shop_id) ->
    api.getPromise('/api/front/api4',{id: opt_shop_id}).then((res) ->
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
  sm.getTags = ->
    api.getPromise('/api/front/all_tags',{}).then((res) ->
      return res
    )
  sm.getReviews = (opt_params) ->
    api.getPromise('/api/front/api23',opt_params).then((res) ->
      return res
    )

  sm.getCasts = (params) ->
    api.getPromise('/api/front/api25',params).then((res) ->
      return res
    )

  sm.getReview = (opt_params) ->
    api.getPromise('/api/front/api26',opt_params).then((res) ->
      return res
    )
  sm.getAllCasts = (params) ->
    api.getPromise('/api/front/api27',params).then((res) ->
      return res
    )
  sm.getContactCasts = (opt_shop_id,opt_cast_ids) ->
    api.postPromise('/api/front/api30',{id: opt_shop_id, cast_ids: opt_cast_ids}).then((res) ->
      return res
    )
  sm.gatTags = ->
    api.getPromise('/api/front/all_tags',params).then((res) ->
      return res
    )

  sm.reaviewQuestions = {
    karaoke:{
      score1: '女の子の対応は良いですか?'
      score2: 'サービスは満足しましたか？'
      score3: '価格に満足してますか?'
      score4: 'お店の雰囲気は良いですか?'
      score5: 'また来たいと思いましたか?'
      info1: 'カラオケの機器は最新の曲でしたか?'
      info2: 'スタッフお対応は良いですか?'
      info3: 'キャストのTip要求は激しいですか'
      info4: '会計時安心しできましたか?'
      info5: '他の方にオススメできますか?'
    },
    bar:{
      score1: '女の子の対応は良いですか?'
      score2: 'サービスは満足しましたか？'
      score3: '価格に満足してますか?'
      score4: 'お店の雰囲気は良いですか?'
      score5: 'また来たいと思いましたか?'
      info1: 'カラオケの機器は最新の曲でしたか?'
      info2: 'スタッフお対応は良いですか?'
      info3: 'キャストのTip要求は激しいですか'
      info4: '会計時安心しできましたか?'
      info5: '他の方にオススメできますか?'
    },
    massage:{
      score1: '女の子の対応は良いですか?'
      score2: 'サービスは満足しましたか？'
      score3: '価格に満足してますか?'
      score4: 'お店の雰囲気は良いですか?'
      score5: 'また来たいと思いましたか?'
      info1: 'リラックスできましたか?'
      info2: 'スタッフお対応は良いですか?'
      info3: 'キャストのTip要求は激しいですか'
      info4: '会計時安心しできましたか?'
      info5: '他の方にオススメできますか?'
    }
  }
  sm.setReaviewQuestion = (job_type) ->
    return sm.reaviewQuestions[job_type]

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
    getShopList: sm.getShopList
    pushPost: sm.pushPost
    getShop: sm.getShop
    sendContact: sm.sendContact
    sendReview: sm.sendReview
    getTags: sm.getTags
    contactValidations: sm.contactValidations
    reviewValidations: sm.reviewValidations
    getReviews: sm.getReviews
    getReview: sm.getReview
    getCasts: sm.getCasts
    getAllCasts: sm.getAllCasts
    getContactCasts: sm.getContactCasts
    gatTags: sm.gatTags
    reaviewQuestions: sm.reaviewQuestions
    setReaviewQuestion: sm.setReaviewQuestion
