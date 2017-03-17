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
      .state '/login/password',
        url: '/login/password'
        active_menu: 'login'
        templateUrl: '/front/tpl/login/password.html'

      .state '/casts/karaoke',
        url: '/casts/karaoke?page&sort&orde&tags&bust'
        active_menu: 'karaoke'
        active_tab: 'cast'
        templateUrl: '/front/tpl/casts/karaoke/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          bust: null
        }

      .state '/shops/karaoke',
        url: '/shops/karaoke?page&sort&order&tags&budget&mama_tip&tip&karaoke_machine&japanese&english&visa&master&jcb'
        active_menu: 'karaoke'
        active_tab: 'shop'
        templateUrl: '/front/tpl/shops/karaoke/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          budget: null
          mama_tip: null
          tip: null
          karaoke_machine: null
          japanese: null
          english: null
          visa: null
          master: null
          jcb: null

        }

      .state '/casts/karaoke/:id',
        url: '/casts/karaoke/:id'
        active_menu: 'karaoke'
        active_tab: 'cast'
        default_url: 'base'
        templateUrl: '/front/tpl/casts/karaoke/detail.html'

      .state '/casts/karaoke/:id.info',
        url: '/info',
        active_menu: 'karaoke'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/casts/common/info.html'


      .state '/casts/karaoke/:id.cast',
          url: '/cast?page&sort&order',
          active_menu: 'karaoke'
          active_tab: 'cast'
          default_url: 'cast'
          templateUrl: '/front/tpl/casts/common/cast.html'

      .state '/casts/karaoke/:id.contact',
        url: '/contact',
        active_menu: 'karaoke'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/casts/common/contact.html'

      .state '/casts/karaoke/:id.reviews',
        url: '/reviews',
        active_menu: 'karaoke'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/casts/common/reviews.html'

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
        url: '/cast?page&sort&order',
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
        url: '/casts/guide?page&sort&orde&tags&bust'
        active_menu: 'guide'
        active_tab: 'cast'
        templateUrl: '/front/tpl/casts/guide/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          bust: null
        }
      .state '/casts/guide/:id',
        url: '/casts/guide/:id'
        active_menu: 'guide'
        active_tab: 'cast'
        default_url: 'base'
        templateUrl: '/front/tpl/casts/guide/detail.html'

      .state '/casts/guide/:id.info',
        url: '/info',
        active_menu: 'guide'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/casts/common/info.html'

      .state '/casts/guide/:id.cast',
        url: '/cast?page&sort&order',
        active_menu: 'guide'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/casts/common/cast.html'

      .state '/casts/guide/:id.contact',
        url: '/contact',
        active_menu: 'guide'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/casts/common/contact.html'

      .state '/casts/guide/:id.reviews',
        url: '/reviews',
        active_menu: 'guide'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/casts/common/reviews.html'

      .state '/casts/bar',
        url: '/casts/bar?page&sort&order&tags&bust'
        active_menu: 'bar'
        templateUrl: '/front/tpl/casts/bar/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          bust: null
        }

      .state '/shops/bar',
        url: '/shops/bar?page&sort&order&tags&budget&mama_tip&tip&charge&karaoke_machine&japanese&english'
        active_menu: 'bar'
        templateUrl: '/front/tpl/shops/bar/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          budget: null
          mama_tip: null
          tip: null
          charge: null
          karaoke_machine: null
          japanese: null
          english: null
          visa: null
          master: null
          jcb: null

        }

      .state '/casts/bar/:id',
        url: '/casts/bar/:id'
        active_menu: 'bar'
        active_tab: 'cast'
        default_url: 'base'
        templateUrl: '/front/tpl/casts/bar/detail.html'

      .state '/casts/bar/:id.info',
        url: '/info',
        active_menu: 'bar'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/casts/common/info.html'

      .state '/casts/bar/:id.cast',
        url: '/cast?page&sort&order',
        active_menu: 'bar'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/casts/common/cast.html'

      .state '/casts/bar/:id.contact',
        url: '/contact',
        active_menu: 'bar'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/casts/common/contact.html'

      .state '/casts/bar/:id.reviews',
        url: '/reviews',
        active_menu: 'bar'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/casts/common/reviews.html'




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

      .state '/shops/bar/:id.write_review',
        url: '/write_review',
        active_menu: 'bar'
        active_tab: 'write_review'
        default_url: 'write_review'
        templateUrl: '/front/tpl/shops/common/write_review.html'



      .state '/casts/massage',
        url: '/casts/massage?page&sort&order&tags&bust'
        active_menu: 'massage'
        templateUrl: '/front/tpl/casts/massage/index.html'
        params: {
          page: null
          sort: null
          order: null
          tags: null
          bust: null
        }

      .state '/shops/massage',
        url: '/shops/massage?page&sort&order&tags&budget&tip&japanese&english'
        active_menu: 'massage'
        templateUrl: '/front/tpl/shops/massage/index.html'
        params: {
          page: null
          sort: null
          order: null
          conditions:null
          tags: null
          budget: null
          tip: null
          japanese: null
          english: null
          visa: null
          master: null
          jcb: null
        }

      .state '/casts/massage/:id',
        url: '/casts/massage/:id'
        active_menu: 'massage'
        active_tab: 'cast'
        default_url: 'base'
        templateUrl: '/front/tpl/casts/massage/detail.html'

      .state '/casts/massage/:id.info',
        url: '/info',
        active_menu: 'massage'
        active_tab: 'info'
        default_url: 'info'
        templateUrl: '/front/tpl/casts/common/info.html'

      .state '/casts/massage/:id.cast',
        url: '/cast?page&sort&order',
        active_menu: 'massage'
        active_tab: 'cast'
        default_url: 'cast'
        templateUrl: '/front/tpl/casts/common/cast.html'

      .state '/casts/massage/:id.contact',
        url: '/contact',
        active_menu: 'massage'
        active_tab: 'contact'
        default_url: 'contact'
        templateUrl: '/front/tpl/casts/common/contact.html'

      .state '/casts/massage/:id.reviews',
        url: '/reviews',
        active_menu: 'massage'
        active_tab: 'reviews'
        default_url: 'reviews'
        templateUrl: '/front/tpl/casts/common/reviews.html'

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

      .state '/shops/massage/:id.write_review',
        url: '/write_review',
        active_menu: 'massage'
        active_tab: 'write_review'
        default_url: 'write_review'
        templateUrl: '/front/tpl/shops/common/write_review.html'

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

      .state '/mypage.shop_reviews',
        url: '/shop_reviews',
        active_menu: 'mypage'
        active_tab: 'shop_reviews'
        default_url: 'shop_reviews'
        templateUrl: '/front/tpl/customer/shop_reviews.html'

      .state '/mypage.user_reviews',
        url: '/cast_reviews',
        active_menu: 'mypage'
        active_tab: 'cast_reviews'
        default_url: 'cast_reviews'
        templateUrl: '/front/tpl/customer/cast_reviews.html'

      .state '/feature/trip',
        url: '/feature/trip',
        templateUrl: '/front/tpl/feature/trip.html'
    .state '/feature/rankinginfo',
      url: '/feature/rankinginfo',
      templateUrl: '/front/tpl/feature/rankinginfo.html'
    .state '/policy',
      url: '/policy'
      active_menu: 'policy'
      templateUrl: '/front/tpl/policy/index_jp.html'
    .state '/terms',
      url: '/terms'
      active_menu: 'terms'
      templateUrl: '/front/tpl/terms/index_jp.html'
    .state '/map',
      url: '/map'
      active_menu: 'map'
      templateUrl: '/front/tpl/map/index.html'

    .state '/events',
      url: '/events'
      templateUrl: '/front/tpl/events/index.html'

    .state '/events/:id/detail',
      url: '/events/:id/detail'
      templateUrl: '/front/tpl/events/detail.html'
