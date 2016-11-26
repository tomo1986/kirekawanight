angular.module 'bijyoZukanAdmin'
  .run ($log, $rootScope, $state, $location, api,user,$http) ->
    'ngInject'
    $rootScope.$on('$stateChangeStart', (e, toState, toParams, fromState, fromParams) ->
      window.scrollTo(0, 0)
    )
    $rootScope.$on '$locationChangeSuccess', ->
      window.scrollTo(0, 0)
