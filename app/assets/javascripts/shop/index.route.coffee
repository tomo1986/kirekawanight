angular.module 'bijyoZukanShop'
  .config ($stateProvider, $urlRouterProvider,$locationProvider) ->
    $locationProvider.html5Mode({
      enabled: true
      requireBase: false
    }).hashPrefix('!')
    $urlRouterProvider.otherwise '/'
    $stateProvider
      .state '/shop',
        url: '/shop'
        active_menu: 'dashboard'
        templateUrl: '/shop/tpl/home/index.html'
      .state '/login',
        url: '/shop/login',
        templateUrl: '/shop/tpl/login/login.html'

      .state '/login.shop_user_sign_in',
        url: '/shop_user_sign_in',
        templateUrl: '/shop/tpl/login/signin.html'

      .state '/login.reset_password',
        url: '/reset_password',
        templateUrl: '/shop/tpl/login/reset_password.html'

      .state '/login.new_password',
        url: '/new_password',
        templateUrl: '/shop/tpl/login/new_password.html'

      .state '/users',
        url: '/shop/users?page'
        active_menu: 'user'
        templateUrl: '/shop/tpl/user/index.html'
      .state '/users/:id/detail',
        url: '/shop/users/:id/detail'
        active_menu: 'user'
        templateUrl: '/shop/tpl/user/detail.html'
      .state '/users/new',
        url: '/shop/users/new'
        active_menu: 'user'
        action: 'create'
        templateUrl: '/shop/tpl/user/form.html'
      .state '/users/:id/edit',
        url: '/shop/users/:id/edit'
        active_menu: 'map'
        action: 'update'
        templateUrl: '/shop/tpl/user/form.html'

    .state '/shops/:id/edit',
      url: '/shop/shops/:id/edit'
      active_menu: 'shop'
      action: 'update'
      templateUrl: '/shop/tpl/shop/form.html'


    .state '/contacts',
      url: '/shop/contacts?page'
      active_menu: 'contact'
      templateUrl: '/shop/tpl/contact/index.html'
    .state '/contacts/:id/detail',
      url: '/shop/contacts/:id/detail'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/shop/tpl/contact/form.html'
    .state '/contacts/new',
      url: '/shop/contacts/new'
      active_menu: 'contact'
      action: 'create'
      templateUrl: '/shop/tpl/contact/form.html'

    .state '/contacts/:id/edit',
      url: '/shop/contacts/:id/edit'
      active_menu: 'contact'
      action: 'update'
      templateUrl: '/shop/tpl/contact/form.html'


    .state '/discounts',
      url: '/shop/discounts?page'
      active_menu: 'discount'
      templateUrl: '/shop/tpl/discount/index.html'

    .state '/discounts/:id/edit',
      url: '/shop/discounts/:id/edit'
      active_menu: 'discount'
      action: 'update'
      templateUrl: '/shop/tpl/discount/form.html'

    .state '/discounts/new',
      url: '/shop/discounts/new'
      active_menu: 'discount'
      action: 'new'
      templateUrl: '/shop/tpl/discount/form.html'
