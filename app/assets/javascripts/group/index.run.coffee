angular.module 'bijyoZukanGroup'
  .run ($log, $rootScope, $state, $location, api,groupService,$http) ->
    'ngInject'
    api.connect().then((res) ->
      groupService.setLoginGroup(res.group)
    )

    $rootScope.$on('$stateChangeStart', (e, toState, toParams, fromState, fromParams) ->
      window.scrollTo(0, 0)
    )
    $rootScope.$on '$locationChangeSuccess', ->
      window.scrollTo(0, 0)
