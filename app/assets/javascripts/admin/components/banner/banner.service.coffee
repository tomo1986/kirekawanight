angular.module 'bijyoZukanAdmin'
.factory 'bannerService', (api) ->
  sm = this
  sm.getSubjects = ->
    api.getPromise('/api/admin/api15',{}).then((res) ->
      return res
    )

  sm.getBanners = ->
    api.getPromise('/api/admin/api25',{}).then((res) ->
      return res
    )
  sm.getBanner = (opt_id)->
    api.getPromise('/api/admin/api26',{id: opt_id}).then((res) ->
      return res
    )
  sm.newBanner = ()->
    api.getPromise('/api/admin/api27',{}).then((res) ->
      return res
    )
  sm.createBanner = (opt_params)->
    api.postPromise('/api/admin/api28',opt_params).then((res) ->
      return res
    )
  sm.updateBanner = (opt_params)->
    api.postPromise('/api/admin/api29',opt_params).then((res) ->
      return res
    )



  service =
    getSubjects: sm.getSubjects
    getBanners: sm.getBanners
    getBanner: sm.getBanner
    newBanner: sm.newBanner
    createBanner: sm.createBanner
    updateBanner: sm.updateBanner