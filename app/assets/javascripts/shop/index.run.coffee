angular.module 'bijyoZukanShop'
  .run ($log, $rootScope, $state, $location, api,shopService,$http) ->
    'ngInject'
    api.connect().then((res) ->
      shopService.setLoginShop(res.shop)
    )

    $rootScope.$on('$stateChangeStart', (e, toState, toParams, fromState, fromParams) ->
      window.scrollTo(0, 0)
    )
    $rootScope.$on '$locationChangeSuccess', ->
      window.scrollTo(0, 0)
