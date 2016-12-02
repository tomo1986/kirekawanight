angular.module 'bijyoZukanShop'
.factory 'bannerService', (api) ->
  sm = this
  sm.getSubjects = ->
    api.getPromise('/api/shop/api15',{}).then((res) ->
      return res
    )

  sm.getBanners = ->
    api.getPromise('/api/shop/api25',{}).then((res) ->
      return res
    )
  sm.getBanner = (opt_id)->
    api.getPromise('/api/shop/api26',{id: opt_id}).then((res) ->
      return res
    )
  sm.newBanner = ()->
    api.getPromise('/api/shop/api27',{}).then((res) ->
      return res
    )
  sm.createBanner = (opt_params)->
    api.postPromise('/api/shop/api28',opt_params).then((res) ->
      return res
    )
  sm.updateBanner = (opt_params)->
    api.postPromise('/api/shop/api29',opt_params).then((res) ->
      return res
    )



  service =
    getSubjects: sm.getSubjects
    getBanners: sm.getBanners
    getBanner: sm.getBanner
    newBanner: sm.newBanner
    createBanner: sm.createBanner
    updateBanner: sm.updateBanner