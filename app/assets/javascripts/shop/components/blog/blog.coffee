angular.module 'bijyoZukanShop'
.factory 'blogService', (api) ->
  sm = this

  sm.getBlogs = (opt_filter) ->
    api.getPromise('/api/shop/api30', opt_filter).then((res) ->
      return res
    )
  sm.getBlog = (opt_blog_id) ->
    api.getPromise('/api/shop/api31',{id: opt_blog_id}).then((res) ->
      return res
    )
  sm.newBlog = ->
    api.getPromise('/api/shop/api32',{}).then((res) ->
      return res
    )
  sm.createBlog = (opt_blog) ->
    api.postPromise('/api/shop/api33',opt_blog).then((res) ->
      return res
    )
  sm.updateBlog = (opt_blog) ->
    api.postPromise('/api/shop/api34',opt_blog).then((res) ->
      return res
    )


  service =
    newBlog: sm.newBlog
    getBlog: sm.getBlog
    createBlog: sm.createBlog
    getBlogs: sm.getBlogs
    updateBlog: sm.updateBlog