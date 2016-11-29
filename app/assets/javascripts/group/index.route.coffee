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


    .state '/discounts',
      url: '/group/discounts?page'
      active_menu: 'discount'
      templateUrl: '/group/tpl/discount/index.html'

    .state '/discounts/:id/edit',
      url: '/group/discounts/:id/edit'
      active_menu: 'discount'
      action: 'update'
      templateUrl: '/group/tpl/discount/form.html'

    .state '/discounts/new',
      url: '/group/discounts/new'
      active_menu: 'discount'
      action: 'new'
      templateUrl: '/group/tpl/discount/form.html'
