angular.module 'bijyoZukanAdmin'
.factory 'blogService', (api) ->
  sm = this

  sm.getBlogs = (opt_filter) ->
    api.getPromise('/api/admin/api30', opt_filter).then((res) ->
      return res
    )
  sm.getBlog = (opt_blog_id) ->
    api.getPromise('/api/admin/api31',{id: opt_blog_id}).then((res) ->
      return res
    )
  sm.newBlog = ->
    api.getPromise('/api/admin/api32',{}).then((res) ->
      return res
    )
  sm.createBlog = (opt_blog) ->
    api.postPromise('/api/admin/api33',opt_blog).then((res) ->
      return res
    )
  sm.updateBlog = (opt_blog) ->
    api.postPromise('/api/admin/api34',opt_blog).then((res) ->
      return res
    )
  sm.getUsers = (params) ->
    api.getPromise('/api/admin/api68',params).then((res) ->
      return res
    )
  sm.getShops = (params) ->
    api.getPromise('/api/admin/api69',params).then((res) ->
      return res
    )


  service =
    newBlog: sm.newBlog
    getBlog: sm.getBlog
    createBlog: sm.createBlog
    getBlogs: sm.getBlogs
    updateBlog: sm.updateBlog
    getUsers: sm.getUsers
    getShops: sm.getShops