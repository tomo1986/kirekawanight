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
        default_url: 'base'
        templateUrl: '/front/tpl/shops/karaoke/detail.html'

      .state '/shops/karaoke/:id.info',
        url: '/info',
        active_menu: 'karaoke'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/shops/common/info.html'

      .state '/shops/karaoke/:id.system',
        url: '/system',
        active_menu: 'karaoke'
        active_tab: 'system'
        default_url: 'system'
        templateUrl: '/front/tpl/shops/common/system.html'

      .state '/shops/karaoke/:id.cast',
        url: '/cast',
        active_menu: 'karaoke'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/shops/common/cast.html'

      .state '/shops/karaoke/:id.contact',
        url: '/contact',
        active_menu: 'karaoke'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/shops/common/contact.html'

      .state '/shops/karaoke/:id.reviews',
        url: '/reviews',
        active_menu: 'karaoke'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/shops/common/reviews.html'
      .state '/shops/karaoke/:id.write_review',
        url: '/write_review',
        active_menu: 'karaoke'
        active_tab: 'write_review'
        default_url: 'write_review'
        templateUrl: '/front/tpl/shops/common/write_review.html'


      .state '/casts/guide',
        url: '/casts/guide?page&sort&orde'
        active_menu: 'guide'
        active_tab: 'cast'
        templateUrl: '/front/tpl/casts/guide/index.html'
        params: {
          page: null
          sort: null
          order: null
        }
      .state '/casts/guide/:id',
        url: '/casts/guide/:id'
        active_menu: 'guide'
        templateUrl: '/front/tpl/casts/guide/detail.html'


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
        active_tab: 'shop'
        default_url: 'base'
        templateUrl: '/front/tpl/shops/bar/detail.html'

      .state '/shops/bar/:id.info',
        url: '/info',
        active_menu: 'bar'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/shops/common/info.html'

      .state '/shops/bar/:id.system',
        url: '/system',
        active_menu: 'bar'
        active_tab: 'system'
        default_url: 'system'
        templateUrl: '/front/tpl/shops/common/system.html'

      .state '/shops/bar/:id.cast',
        url: '/cast',
        active_menu: 'bar'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/shops/common/cast.html'

      .state '/shops/bar/:id.contact',
        url: '/contact',
        active_menu: 'bar'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/shops/common/contact.html'

      .state '/shops/bar/:id.reviews',
        url: '/reviews',
        active_menu: 'bar'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/shops/common/reviews.html'


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
        active_tab: 'shop'
        default_url: 'base'
        templateUrl: '/front/tpl/shops/massage/detail.html'

      .state '/shops/massage/:id.info',
        url: '/info',
        active_menu: 'massage'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/shops/common/info.html'

      .state '/shops/massage/:id.system',
        url: '/system',
        active_menu: 'massage'
        active_tab: 'system'
        default_url: 'system'
        templateUrl: '/front/tpl/shops/common/system.html'

      .state '/shops/massage/:id.cast',
        url: '/cast',
        active_menu: 'massage'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/shops/common/cast.html'

      .state '/shops/massage/:id.contact',
        url: '/contact',
        active_menu: 'massage'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/shops/common/contact.html'

      .state '/shops/massage/:id.reviews',
        url: '/reviews',
        active_menu: 'massage'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/shops/common/reviews.html'

#      .state '/casts/sexy',
#        url: '/casts/sexy?page&sort&order'
#        active_menu: 'sexy'
#        templateUrl: '/front/tpl/casts/sexy/index.html'
#        params: {
#          page: null
#          sort: null
#          order: null
#        }
#      .state '/casts/sexy/:id',
#        url: '/casts/sexy/:id'
#        active_menu: 'sexy'
#        templateUrl: '/front/tpl/casts/sexy/detail.html'

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
        default_url: 'base'
        templateUrl: '/front/tpl/customer/detail.html'

      .state '/mypage.show',
        url: '/show'
        active_menu: 'mypage'
        active_tab: 'show'
        default_url: 'show'
        templateUrl: '/front/tpl/customer/show.html'

      .state '/mypage.edit',
        url: '/edit',
        active_menu: 'mypage'
        active_tab: 'edit'
        default_url: 'edit'
        templateUrl: '/front/tpl/customer/form.html'

      .state '/mypage.contacts',
        url: '/contacts',
        active_menu: 'mypage'
        active_tab: 'contacts'
        default_url: 'contacts'
        templateUrl: '/front/tpl/customer/contacts.html'

      .state '/mypage.reviews',
        url: '/reviews',
        active_menu: 'mypage'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/customer/reviews.html'
