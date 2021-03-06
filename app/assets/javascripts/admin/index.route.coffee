angular.module 'bijyoZukanAdmin'
  .config ($stateProvider, $urlRouterProvider,$locationProvider) ->
    $locationProvider.html5Mode({
      enabled: true
      requireBase: false
    }).hashPrefix('!')
    $urlRouterProvider.otherwise '/'
    $stateProvider
      .state '/admin',
        url: '/admin'
        active_menu: 'dashboard'
        templateUrl: '/admin/tpl/home/index.html'
      .state '/login',
        url: '/admin/login',
        templateUrl: '/admin/tpl/login/login.html'

      .state '/login.admin_user_sign_in',
        url: '/admin_user_sign_in',
        templateUrl: '/admin/tpl/login/signin.html'

      .state '/login.reset_password',
        url: '/reset_password',
        templateUrl: '/admin/tpl/login/reset_password.html'

      .state '/login.new_password',
        url: '/new_password',
        templateUrl: '/admin/tpl/login/new_password.html'

      .state '/admins',
        url: '/admin/admins'
        templateUrl: '/admin/tpl/admin/index.html'

      .state '/admins/new',
        url: '/admin/admins/new'
        action: 'create'
        templateUrl: '/admin/tpl/admin/form.html'
      .state '/admins/:id/edit',
        url: '/admin/admins/:id/edit'
        action: 'update'
        templateUrl: '/admin/tpl/admin/form.html'


      .state '/users',
        url: '/admin/users?page&sort&orde&keyword&group_id&shop_id&job_type'
        active_menu: 'user'
        templateUrl: '/admin/tpl/user/index.html'
        params: {
          page: null
          sort: null
          order: null
          keyword: null
          group_id: null
          shop_id: null
          job_type: null
        }

      .state '/users/:id/detail',
        url: '/admin/users/:id/detail'
        active_menu: 'user'
        templateUrl: '/admin/tpl/user/detail.html'
      .state '/users/new',
        url: '/admin/users/new'
        active_menu: 'user'
        action: 'create'
        templateUrl: '/admin/tpl/user/form.html'
      .state '/users/:id/edit',
        url: '/admin/users/:id/edit'
        active_menu: 'map'
        action: 'update'
        templateUrl: '/admin/tpl/user/form.html'

    .state '/groups',
      url: '/admin/groups?page'
      active_menu: 'group'
      templateUrl: '/admin/tpl/group/index.html'

    .state '/groups/:id/detail',
      url: '/admin/groups/:id/detail'
      active_menu: 'group'
      templateUrl: '/admin/tpl/group/detail.html'

    .state '/groups/new',
      url: '/admin/groups/new'
      active_menu: 'group'
      action: 'create'
      templateUrl: '/admin/tpl/group/form.html'

    .state '/groups/:id/edit',
      url: '/admin/groups/:id/edit'
      active_menu: 'group'
      action: 'update'
      templateUrl: '/admin/tpl/group/form.html'




    .state '/shops',
      url: '/admin/shops?page'
      active_menu: 'shop'
      templateUrl: '/admin/tpl/shop/index.html'

    .state '/shops/:id/detail',
      url: '/admin/shops/:id/detail'
      active_menu: 'shop'
      templateUrl: '/admin/tpl/shop/detail.html'

    .state '/shops/new',
      url: '/admin/shops/new'
      active_menu: 'shop'
      action: 'create'
      templateUrl: '/admin/tpl/shop/form.html'

    .state '/shops/:id/edit',
      url: '/admin/shops/:id/edit'
      active_menu: 'shop'
      action: 'update'
      templateUrl: '/admin/tpl/shop/form.html'



    .state '/contacts',
      url: '/admin/contacts?page'
      active_menu: 'contact'
      templateUrl: '/admin/tpl/contact/index.html'
    .state '/contacts/:id/detail',
      url: '/admin/contacts/:id/detail'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/admin/tpl/contact/form.html'
    .state '/contacts/new',
      url: '/admin/contacts/new'
      active_menu: 'contact'
      action: 'create'
      templateUrl: '/admin/tpl/contact/form.html'

    .state '/contacts/:id/edit',
      url: '/admin/contacts/:id/edit'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/admin/tpl/contact/form.html'


    .state '/banners',
      url: '/admin/banners?page'
      active_menu: 'banner'
      templateUrl: '/admin/tpl/banner/index.html'

    .state '/banners/:id/detail',
      url: '/admin/banners/:id/detail'
      active_menu: 'banner'
      action: 'update'
      templateUrl: '/admin/tpl/banner/detail.html'

    .state '/banners/new',
      url: '/admin/banners/new'
      active_menu: 'banner'
      action: 'create'
      templateUrl: '/admin/tpl/banner/form.html'


    .state '/banners/:id/edit',
      url: '/admin/banners/:id/edit'
      active_menu: 'banner'
      action: 'update'
      templateUrl: '/admin/tpl/banner/form.html'






    .state '/pickups',
      url: '/admin/pickups?page'
      active_menu: 'pickup'
      templateUrl: '/admin/tpl/pickup/index.html'

    .state '/pickups/:id/detail',
      url: '/admin/pickups/:id/detail'
      active_menu: 'pickup'
      templateUrl: '/admin/tpl/pickup/detail.html'

    .state '/pickups/new',
      url: '/admin/pickups/new'
      active_menu: 'pickup'
      action: 'create'
      templateUrl: '/admin/tpl/pickup/form.html'

    .state '/pickups/:id/edit',
      url: '/admin/pickups/:id/edit'
      active_menu: 'pickup'
      action: 'update'
      templateUrl: '/admin/tpl/pickup/form.html'

    .state '/events',
      url: '/admin/events?page'
      active_menu: 'event'
      templateUrl: '/admin/tpl/event/index.html'

    .state '/events/:id/detail',
      url: '/admin/events/:id/detail'
      active_menu: 'event'
      templateUrl: '/admin/tpl/event/detail.html'

    .state '/events/new',
      url: '/admin/events/new'
      active_menu: 'event'
      action: 'create'
      templateUrl: '/admin/tpl/event/form.html'

    .state '/events/:id/edit',
      url: '/admin/events/:id/edit'
      active_menu: 'event'
      action: 'update'
      templateUrl: '/admin/tpl/event/form.html'



    .state '/blogs',
      url: '/admin/blogs?page'
      active_menu: 'blog'
      templateUrl: '/admin/tpl/blog/index.html'

    .state '/blogs/:id/detail',
      url: '/admin/blogs/:id/detail'
      active_menu: 'blog'
      templateUrl: '/admin/tpl/blog/detail.html'

    .state '/blogs/new',
      url: '/admin/blogs/new'
      active_menu: 'blog'
      action: 'create'
      templateUrl: '/admin/tpl/blog/form.html'

    .state '/blogs/:id/edit',
      url: '/admin/blogs/:id/edit'
      active_menu: 'blog'
      action: 'update'
      templateUrl: '/admin/tpl/blog/form.html'



    .state '/invoices',
      url: '/admin/invoices?page'
      active_menu: 'invoice'
      templateUrl: '/admin/tpl/invoice/index.html'
      params: {
        page: null
        sort: null
        order: null
        keyword: null
        group_id: null
        shop_id: null
        job_type: null
      }

    .state '/invoices/:id/detail',
      url: '/admin/invoices/:id/detail'
      active_menu: 'invoice'
      templateUrl: '/admin/tpl/invoice/detail.html'

    .state '/invoices/new',
      url: '/admin/invoices/new'
      active_menu: 'invoice'
      action: 'create'
      templateUrl: '/admin/tpl/invoice/form.html'

    .state '/invoices/:id/edit',
      url: '/admin/invoices/:id/edit'
      active_menu: 'invoice'
      action: 'update'
      templateUrl: '/admin/tpl/invoice/form.html'

    .state '/invoices/prints',
      url: '/admin/invoices/prints?ids'
      active_menu: 'invoice'
      action: 'update'
      templateUrl: '/admin/tpl/invoice/prints.html'
