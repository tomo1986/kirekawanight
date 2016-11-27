angular.module 'bijyoZukanGroup'
  .config ($stateProvider, $urlRouterProvider,$locationProvider) ->
    $locationProvider.html5Mode({
      enabled: true
      requireBase: false
    }).hashPrefix('!')
    $urlRouterProvider.otherwise '/'
    $stateProvider
      .state '/group',
        url: '/group'
        active_menu: 'dashboard'
        templateUrl: '/group/tpl/home/index.html'
      .state '/login',
        url: '/group/login',
        templateUrl: '/group/tpl/login/login.html'

      .state '/login.group_user_sign_in',
        url: '/group_user_sign_in',
        templateUrl: '/group/tpl/login/signin.html'

      .state '/login.reset_password',
        url: '/reset_password',
        templateUrl: '/group/tpl/login/reset_password.html'

      .state '/login.new_password',
        url: '/new_password',
        templateUrl: '/group/tpl/login/new_password.html'

      .state '/users',
        url: '/group/users?page'
        active_menu: 'user'
        templateUrl: '/group/tpl/user/index.html'
      .state '/users/:id/detail',
        url: '/group/users/:id/detail'
        active_menu: 'user'
        templateUrl: '/group/tpl/user/detail.html'
      .state '/users/new',
        url: '/group/users/new'
        active_menu: 'user'
        action: 'create'
        templateUrl: '/group/tpl/user/form.html'
      .state '/users/:id/edit',
        url: '/group/users/:id/edit'
        active_menu: 'map'
        action: 'update'
        templateUrl: '/group/tpl/user/form.html'

    .state '/groups',
      url: '/group/groups?page'
      active_menu: 'group'
      templateUrl: '/group/tpl/group/index.html'

    .state '/groups/:id/detail',
      url: '/group/groups/:id/detail'
      active_menu: 'group'
      templateUrl: '/group/tpl/group/detail.html'

    .state '/groups/new',
      url: '/group/groups/new'
      active_menu: 'group'
      action: 'create'
      templateUrl: '/group/tpl/group/form.html'

    .state '/groups/:id/edit',
      url: '/group/groups/:id/edit'
      active_menu: 'group'
      action: 'update'
      templateUrl: '/group/tpl/group/form.html'


    .state '/contacts',
      url: '/group/contacts?page'
      active_menu: 'contact'
      templateUrl: '/group/tpl/contact/index.html'
    .state '/contacts/:id/detail',
      url: '/group/contacts/:id/detail'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/group/tpl/contact/form.html'
    .state '/contacts/new',
      url: '/group/contacts/new'
      active_menu: 'contact'
      action: 'create'
      templateUrl: '/group/tpl/contact/form.html'

    .state '/contacts/:id/edit',
      url: '/group/contacts/:id/edit'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/group/tpl/contact/form.html'


    .state '/banners',
      url: '/group/banners?page'
      active_menu: 'banner'
      templateUrl: '/group/tpl/banner/index.html'

    .state '/banners/:id/detail',
      url: '/group/banners/:id/detail'
      active_menu: 'banner'
      action: 'update'
      templateUrl: '/group/tpl/banner/detail.html'

    .state '/banners/new',
      url: '/group/banners/new'
      active_menu: 'banner'
      action: 'create'
      templateUrl: '/group/tpl/banner/form.html'


    .state '/banners/:id/edit',
      url: '/group/banners/:id/edit'
      active_menu: 'banner'
      action: 'update'
      templateUrl: '/group/tpl/banner/form.html'






    .state '/pickups',
      url: '/group/pickups?page'
      active_menu: 'pickup'
      templateUrl: '/group/tpl/pickup/index.html'

    .state '/pickups/:id/detail',
      url: '/group/pickups/:id/detail'
      active_menu: 'pickup'
      templateUrl: '/group/tpl/pickup/detail.html'

    .state '/pickups/new',
      url: '/group/pickups/new'
      active_menu: 'pickup'
      action: 'create'
      templateUrl: '/group/tpl/pickup/form.html'

    .state '/pickups/:id/edit',
      url: '/group/pickups/:id/edit'
      active_menu: 'pickup'
      action: 'update'
      templateUrl: '/group/tpl/pickup/form.html'



    .state '/blogs',
      url: '/group/blogs?page'
      active_menu: 'blog'
      templateUrl: '/group/tpl/blog/index.html'

    .state '/blogs/:id/detail',
      url: '/group/blogs/:id/detail'
      active_menu: 'blog'
      templateUrl: '/group/tpl/blog/detail.html'

    .state '/blogs/new',
      url: '/group/blogs/new'
      active_menu: 'blog'
      action: 'create'
      templateUrl: '/group/tpl/blog/form.html'

    .state '/blogs/:id/edit',
      url: '/group/blogs/:id/edit'
      active_menu: 'blog'
      action: 'update'
      templateUrl: '/group/tpl/blog/form.html'
