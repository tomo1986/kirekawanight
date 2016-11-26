angular.module 'bisyoujoZukanNight'
  .run ($log, $rootScope, $state, $location, api,$http, $timeout, customerService) ->
    'ngInject'
    api.connect().then((res) ->
      console.log(res)
      customerService.setLoginCustomer(res.login_customer)
    )

    $rootScope.$on('$stateChangeStart', (e, toState, toParams, fromState, fromParams) ->
      window.scrollTo(0, 0)
    )
    $rootScope.$on '$locationChangeSuccess', (e, toState, toParams, fromState, fromParams) ->
      window.scrollTo(0, 0)
      $rootScope.actualLocation = $location.path()
      $rootScope.history_url = toParams
      $(window).unbind('scroll').bind('scroll', ()->
        if $(window).scrollTop() > window.innerHeight
          $('.scroll-top').fadeIn(500)
        else
          $('.scroll-top').fadeOut(500)
        return
      )
      waitingTime = if($location.path() == '/') then 6000 else 100
      $timeout (->
        $rootScope.okSaveScroll = true
      ), 100
      $('body').addClass('fade-layer-off')
      $('<div class="fade-layer"/>').prependTo('body').fadeOut(1000, ->
        $(this).remove();
      )
      $(window).on("beforeunload",(e) ->
        $('body').fadeOut()
      )
      return

