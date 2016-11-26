angular.module 'bisyoujoZukanNight'
.factory 'api', ($log,$http, $q, $timeout,$httpParamSerializerJQLike) ->
  vm = this
  host = location.protocol + '//' + location.host
  apiHost = '/api/business/'

  connect = ->
    self = vm
    return new Promise((resolve, reject) ->
      get '/api/front/api0', {}, ((data) ->
        self.user = data.user
        resolve data
      ), (error) ->
        self.user = null
        reject error
    )
  run = (url, httpMethod, params, callbackSuccess = null, callbackFailed = null) ->

    http = $http
      url: host + url
      method: httpMethod
      data: $httpParamSerializerJQLike(params)
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    http.then((response) ->
      $log.debug 'api' + url + ' success.', response.data
      callbackSuccess(response.data) if (callbackSuccess)
    ).catch((error) ->
      $log.error 'api' + url + ' have error.', error
      callbackFailed(error.data) if (callbackFailed)
    )

  post = (url, params, callbackSuccess = null, callbackFailed = null) ->
    run(url, 'POST', params, callbackSuccess, callbackFailed)

  get = (url, params, callbackSuccess = null, callbackFailed = null) ->
    run(url, 'GET', params, callbackSuccess, callbackFailed)

  runPromise = (url, httpMethod, params, callbackSuccess = null, callbackFailed = null) ->
    post_data = if httpMethod == 'POST' then $httpParamSerializerJQLike(params) else ''
    get_param = if httpMethod == 'GET' then params else ''
    deferred = $q.defer()
    http =
      $http
        url: host + url
        method: httpMethod
        params: get_param
        data: post_data
        headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
    http.then((response) ->
      console.log(url,"：",response)
      if(typeof response.data == 'object')
        deferred.resolve(response)
      else
        error = {error: 'エラーが発生しました。'}
        deferred.reject(error)
    )
    deferred.promise

  getPromise = (url, params, callbackSuccess = null, callbackFailed = null) ->
    runPromise(url, 'GET', params, callbackSuccess, callbackFailed)

  postPromise = (url, params, callbackSuccess = null, callbackFailed = null) ->
    runPromise(url, 'POST', params, callbackSuccess, callbackFailed)

  service =
    host: host
    apiHost: apiHost
    connect: connect
    run: run
    post: post
    get: get
    getPromise: getPromise
    postPromise: postPromise
    runPromise: runPromise
