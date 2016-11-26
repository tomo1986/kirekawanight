angular.module 'bisyoujoZukanNight'
  .config ($stateProvider, $urlRouterProvider,$locationProvider) ->
    $locationProvider.html5Mode({
      enabled: true
      requireBase: false
    }).hashPrefix('!')
    $urlRouterProvider.otherwise '/'
    $stateProvider
      .state '/',
        url: '/'
        active_menu: 'home'
        templateUrl: '/front/tpl/home/index.html'

      .state '/login',
        url: '/login'
        active_menu: 'login'
        templateUrl: '/front/tpl/login/login.html'


      .state '/casts/karaoke',
        url: '/casts/karaoke?page'
        active_menu: 'karaoke'
        active_tab: 'cast'
        templateUrl: '/front/tpl/casts/karaoke/index.html'

      .state '/groups/karaoke',
        url: '/groups/karaoke?page'
        active_menu: 'karaoke'
        active_tab: 'shop'
        templateUrl: '/front/tpl/groups/karaoke/index.html'


      .state '/casts/karaoke/:id',
        url: '/casts/karaoke/:id'
        active_menu: 'karaoke'
        templateUrl: '/front/tpl/casts/karaoke/detail.html'

      .state '/groups/karaoke/:id',
        url: '/groups/karaoke/:id'
        active_menu: 'karaoke'
        active_tab: 'shop'
        templateUrl: '/front/tpl/groups/karaoke/detail.html'



      .state '/casts/bar',
        url: '/casts/bar?page'
        active_menu: 'bar'
        templateUrl: '/front/tpl/casts/bar/index.html'
      .state '/groups/bar',
        url: '/groups/bar?page'
        active_menu: 'bar'
        templateUrl: '/front/tpl/groups/bar/index.html'


      .state '/casts/bar/:id',
        url: '/casts/bar/:id'
        active_menu: 'bar'
        templateUrl: '/front/tpl/casts/bar/detail.html'
      .state '/groups/bar/:id',
        url: '/groups/bar/:id'
        active_menu: 'bar'
        templateUrl: '/front/tpl/groups/bar/detail.html'


      .state '/casts/massage',
        url: '/casts/massage?page'
        active_menu: 'massage'
        templateUrl: '/front/tpl/casts/massage/index.html'
      .state '/groups/massage',
        url: '/groups/massage?page'
        active_menu: 'massage'
        templateUrl: '/front/tpl/groups/massage/index.html'

      .state '/casts/massage/:id',
        url: '/casts/massage/:id'
        active_menu: 'massage'
        templateUrl: '/front/tpl/casts/massage/detail.html'
      .state '/groups/massage/:id',
        url: '/groups/massage/:id'
        active_menu: 'massage'
        templateUrl: '/front/tpl/groups/massage/detail.html'

      .state '/casts/sexy',
        url: '/casts/sexy?page'
        active_menu: 'sexy'
        templateUrl: '/front/tpl/casts/sexy/index.html'

      .state '/casts/sexy/:id',
        url: '/casts/sexy/:id'
        active_menu: 'sexy'
        templateUrl: '/front/tpl/casts/sexy/detail.html'

      .state '/casts',
        url: '/casts'
        active_menu: 'cast'
        templateUrl: '/front/tpl/casts/index.html'

      .state '/casts/:id',
        url: '/casts/:id'
        active_menu: 'cast'
        templateUrl: '/front/tpl/casts/detail.html'

      .state '/system',
        url: '/system'
        active_menu: 'system'
        templateUrl: '/front/tpl/system/index_jp.html'

      .state '/comsept',
        url: '/comsept'
        active_menu: 'comsept'
        templateUrl: '/front/tpl/comsept/index_jp.html'

      .state '/question',
        url: '/question'
        templateUrl: '/front/tpl/question/index_jp.html'
      .state '/visitor',
        url: '/visitor'
        templateUrl: '/front/tpl/visitor/index_jp.html'


      .state '/contact',
        url: '/contact?type'
        active_menu: 'contact'
        templateUrl: '/front/tpl/contact/index_jp.html'


      .state '/reserve',
        url: '/reserve'
        active_menu: 'reserve'
        templateUrl: '/front/tpl/reserve/index.html'

      .state '/mypage',
        url: '/mypage'
        templateUrl: '/front/tpl/customer/detail.html'

      .state '/mypage/edit',
        url: '/mypage/edit'
        templateUrl: '/front/tpl/customer/from.html'
