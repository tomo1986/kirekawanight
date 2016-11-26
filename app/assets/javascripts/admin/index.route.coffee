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

      .state '/users',
        url: '/admin/users?page'
        active_menu: 'user'
        templateUrl: '/admin/tpl/user/index.html'
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
