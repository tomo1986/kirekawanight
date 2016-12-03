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
        url: '/casts/karaoke?page&sort&orde'
        active_menu: 'karaoke'
        active_tab: 'cast'
        templateUrl: '/front/tpl/casts/karaoke/index.html'
        params: {
          page: null
          sort: null
          order: null
        }

      .state '/shops/karaoke',
        url: '/shops/karaoke?page&sort&order'
        active_menu: 'karaoke'
        active_tab: 'shop'
        templateUrl: '/front/tpl/shops/karaoke/index.html'
        params: {
          page: null
          sort: null
          order: null
        }

      .state '/casts/karaoke/:id',
        url: '/casts/karaoke/:id'
        active_menu: 'karaoke'
        templateUrl: '/front/tpl/casts/karaoke/detail.html'

      .state '/shops/karaoke/:id',
        url: '/shops/karaoke/:id'
        active_menu: 'karaoke'
        active_tab: 'shop'
        templateUrl: '/front/tpl/shops/karaoke/detail.html'



      .state '/casts/bar',
        url: '/casts/bar?page&sort&order'
        active_menu: 'bar'
        templateUrl: '/front/tpl/casts/bar/index.html'
        params: {
          page: null
          sort: null
          order: null
        }



      .state '/shops/bar',
        url: '/shops/bar?page&sort&order'
        active_menu: 'bar'
        templateUrl: '/front/tpl/shops/bar/index.html'
        params: {
          page: null
          sort: null
          order: null
        }


      .state '/casts/bar/:id',
        url: '/casts/bar/:id'
        active_menu: 'bar'
        templateUrl: '/front/tpl/casts/bar/detail.html'
      .state '/shops/bar/:id',
        url: '/shops/bar/:id'
        active_menu: 'bar'
        templateUrl: '/front/tpl/shops/bar/detail.html'


      .state '/casts/massage',
        url: '/casts/massage?page&sort&order'
        active_menu: 'massage'
        templateUrl: '/front/tpl/casts/massage/index.html'
        params: {
          page: null
          sort: null
          order: null
        }


      .state '/shops/massage',
        url: '/shops/massage?page&sort&order'
        active_menu: 'massage'
        templateUrl: '/front/tpl/shops/massage/index.html'
        params: {
          page: null
          sort: null
          order: null
        }

      .state '/casts/massage/:id',
        url: '/casts/massage/:id'
        active_menu: 'massage'
        templateUrl: '/front/tpl/casts/massage/detail.html'
      .state '/shops/massage/:id',
        url: '/shops/massage/:id'
        active_menu: 'massage'
        templateUrl: '/front/tpl/shops/massage/detail.html'

      .state '/casts/sexy',
        url: '/casts/sexy?page&sort&order'
        active_menu: 'sexy'
        templateUrl: '/front/tpl/casts/sexy/index.html'
        params: {
          page: null
          sort: null
          order: null
        }
      .state '/casts/sexy/:id',
        url: '/casts/sexy/:id'
        active_menu: 'sexy'
        templateUrl: '/front/tpl/casts/sexy/detail.html'

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

      .state '/sitemap',
        url: '/sitemap'
        templateUrl: '/front/tpl/sitemap/index_jp.html'


      .state '/mypage',
        url: '/mypage'
        templateUrl: '/front/tpl/customer/detail.html'

      .state '/mypage/edit',
        url: '/mypage/edit'
        templateUrl: '/front/tpl/customer/from.html'
