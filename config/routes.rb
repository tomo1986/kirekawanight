Rails.application.routes.draw do
  devise_for :shops
  devise_for :groups
  devise_for :admin
  devise_for :customers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'front/home#index'

  namespace :group do
    root to: 'pages#index', via: :get
    devise_for :groups, path_prefix: '/group',controllers: {},:skip => [:sessions,:passwords]
    as :group do
      match '/sign_out' => 'sessions#destroy', :as => :destroy_group_session,
            :via => Devise.mappings[:group].sign_out_via
    end
    get 'login',to: 'pages#login'
    get 'users',to: 'pages#index'
    get 'users/:id/detail',to: 'pages#index'
    get 'users/:id/edit',to: 'pages#index'
    get 'users/new',to: 'pages#index'
    get 'groups',to: 'pages#index'
    get 'groups/:id/detail',to: 'pages#index'
    get 'groups/:id/edit',to: 'pages#index'
    get 'groups/new',to: 'pages#index'

    get 'shops',to: 'pages#index'
    get 'shops/:id/detail',to: 'pages#index'
    get 'shops/:id/edit',to: 'pages#index'
    get 'shops/new',to: 'pages#index'

    get 'discounts',to: 'pages#index'
    get 'discounts/:id/detail',to: 'pages#index'
    get 'discounts/:id/edit',to: 'pages#index'
    get 'discounts/new',to: 'pages#index'


    get 'tpl/:name.html' => 'pages#templates'
    get 'tpl/:path1/:name.html' => 'pages#templates'
    get 'tpl/:path1/:path2/:name.html' => 'pages#templates'
  end
  namespace :shop do
    root to: 'pages#index', via: :get
    devise_for :shops, path_prefix: '/shop',controllers: {},:skip => [:sessions,:passwords]
    as :shop do
      match '/sign_out' => 'sessions#destroy', :as => :destroy_group_session,
            :via => Devise.mappings[:shop].sign_out_via
    end
    get 'login',to: 'pages#login'
    get 'users',to: 'pages#index'
    get 'users/:id/detail',to: 'pages#index'
    get 'users/:id/edit',to: 'pages#index'
    get 'users/new',to: 'pages#index'
    get 'groups',to: 'pages#index'
    get 'groups/:id/detail',to: 'pages#index'
    get 'groups/:id/edit',to: 'pages#index'
    get 'groups/new',to: 'pages#index'

    get 'discounts',to: 'pages#index'
    get 'discounts/:id/detail',to: 'pages#index'
    get 'discounts/:id/edit',to: 'pages#index'
    get 'discounts/new',to: 'pages#index'


    get 'tpl/:name.html' => 'pages#templates'
    get 'tpl/:path1/:name.html' => 'pages#templates'
    get 'tpl/:path1/:path2/:name.html' => 'pages#templates'
  end

  namespace :admin do
    root to: 'pages#index', via: :get
    devise_for :admin, path_prefix: '/admin',controllers: {},:skip => [:sessions,:passwords]
    as :admin do
      match '/sign_out' => 'sessions#destroy', :as => :destroy_admin_session,
            :via => Devise.mappings[:admin].sign_out_via
    end
    get 'login',to: 'pages#login'
    get 'admins',to: 'pages#index'
    get 'admins/new',to: 'pages#index'
    get 'admins/:id/edit',to: 'pages#index'

    get 'users',to: 'pages#index'
    get 'users/:id/detail',to: 'pages#index'
    get 'users/:id/edit',to: 'pages#index'
    get 'users/new',to: 'pages#index'
    get 'groups',to: 'pages#index'
    get 'groups/:id/detail',to: 'pages#index'
    get 'groups/:id/edit',to: 'pages#index'
    get 'groups/new',to: 'pages#index'

    get 'shops',to: 'pages#index'
    get 'shops/:id/detail',to: 'pages#index'
    get 'shops/:id/edit',to: 'pages#index'
    get 'shops/new',to: 'pages#index'



    get 'blogs',to: 'pages#index'
    get 'blogs/:id/detail',to: 'pages#index'
    get 'blogs/:id/edit',to: 'pages#index'
    get 'blogs/new',to: 'pages#index'
    get 'contacts',to: 'pages#index'
    get 'contacts/:id/detail',to: 'pages#index'
    get 'contacts/:id/edit',to: 'pages#index'
    get 'contacts/new',to: 'pages#index'
    get 'banners',to: 'pages#index'
    get 'banners/:id/detail',to: 'pages#index'
    get 'banners/:id/edit',to: 'pages#index'
    get 'banners/new',to: 'pages#index'
    get 'pickups',to: 'pages#index'
    get 'pickups/:id/detail',to: 'pages#index'
    get 'pickups/:id/edit',to: 'pages#index'
    get 'pickups/new',to: 'pages#index'

    get 'invoices',to: 'pages#index'
    get 'invoices/:id/detail',to: 'pages#index'
    get 'invoices/:id/edit',to: 'pages#index'
    get 'invoices/new',to: 'pages#index'
    get 'invoices/prints',to: 'pages#prints'


    get 'tpl/:name.html' => 'pages#templates'
    get 'tpl/:path1/:name.html' => 'pages#templates'
    get 'tpl/:path1/:path2/:name.html' => 'pages#templates'
  end


  scope module: 'front' do
    devise_for :customers, path_prefix: '/',controllers: {},:skip => [:sessions,:passwords]
    devise_scope :customer do
      get 'customers/sign_out' => 'devise/sessions#destroy',
          :via => Devise.mappings[:customer].sign_out_via
    end
    get 'index', to: 'home#index'
    get 'login',to: 'home#login'
    get 'login/password', to: 'home#login'
    get 'logout', to: 'home#logout'
    get 'mypage',to: 'home#mypage'
    get 'mypage/edit', to: 'home#mypage_edit'
    get 'mypage/show',to: 'home#mypage_show'
    get 'mypage/contacts', to: 'home#index'
    get 'mypage/shop_reviews', to: 'home#index'
    get 'mypage/cast_reviews', to: 'home#index'

    get 'casts/karaoke', to: 'home#cast_karaoke'
    get 'casts/karaoke/:id', to: 'home#index'
    get 'casts/karaoke/:id/info', to: 'home#index'
    get 'casts/karaoke/:id/system', to: 'home#index'
    get 'casts/karaoke/:id/cast', to: 'home#index'
    get 'casts/karaoke/:id/contact', to: 'home#index'
    get 'casts/karaoke/:id/reviews', to: 'home#index'

    get 'casts/guide', to: 'home#index'
    get 'casts/guide/:id', to: 'home#index'
    get 'casts/guide/:id/info', to: 'home#index'
    get 'casts/guide/:id/system', to: 'home#index'
    get 'casts/guide/:id/cast', to: 'home#index'
    get 'casts/guide/:id/contact', to: 'home#index'
    get 'casts/guide/:id/reviews', to: 'home#index'

    get 'shops/karaoke', to: 'home#shop_karaoke'
    get 'shops/karaoke/:id', to: 'home#index'
    get 'shops/karaoke/:id/info', to: 'home#index'
    get 'shops/karaoke/:id/system', to: 'home#index'
    get 'shops/karaoke/:id/cast', to: 'home#index'
    get 'shops/karaoke/:id/contact', to: 'home#index'
    get 'shops/karaoke/:id/reviews', to: 'home#index'
    get 'shops/karaoke/:id/write_review', to: 'home#index'

    get 'casts/bar', to: 'home#cast_bar'
    get 'casts/bar/:id', to: 'home#index'
    get 'casts/bar/:id/info', to: 'home#index'
    get 'casts/bar/:id/system', to: 'home#index'
    get 'casts/bar/:id/cast', to: 'home#index'
    get 'casts/bar/:id/contact', to: 'home#index'
    get 'casts/bar/:id/reviews', to: 'home#index'

    get 'shops/bar', to: 'home#shop_bar'
    get 'shops/bar/:id', to: 'home#index'
    get 'shops/bar/:id/info', to: 'home#index'
    get 'shops/bar/:id/system', to: 'home#index'
    get 'shops/bar/:id/cast', to: 'home#index'
    get 'shops/bar/:id/contact', to: 'home#index'
    get 'shops/bar/:id/reviews', to: 'home#index'
    get 'shops/bar/:id/write_review', to: 'home#index'

    get 'casts/massage', to: 'home#cast_massage'
    get 'casts/massage/:id', to: 'home#index'
    get 'casts/massage/:id/info', to: 'home#index'
    get 'casts/massage/:id/system', to: 'home#index'
    get 'casts/massage/:id/cast', to: 'home#index'
    get 'casts/massage/:id/contact', to: 'home#index'
    get 'casts/massage/:id/reviews', to: 'home#index'

    get 'shops/massage', to: 'home#shop_massage'
    get 'shops/massage/:id', to: 'home#index'
    get 'shops/massage/:id/info', to: 'home#index'
    get 'shops/massage/:id/system', to: 'home#index'
    get 'shops/massage/:id/cast', to: 'home#index'
    get 'shops/massage/:id/contact', to: 'home#index'
    get 'shops/massage/:id/reviews', to: 'home#index'
    get 'shops/massage/:id/write_review', to: 'home#index'


    get 'feature/trip', to: 'home#index'
    get 'feature/rankinginfo', to: 'home#index'

    # get 'casts/sexy', to: 'home#cast_sexy'
    # get 'casts/sexy/:id', to: 'home#index'

    get 'system', to: 'home#index'
    get 'comsept', to: 'home#index'
    get 'question', to: 'home#index'
    get 'visitor', to: 'home#index'
    get 'policy', to: 'home#index'
    get 'contact', to: 'home#index'
    get 'reserve', to: 'home#index'
    get 'sitemap', to: 'home#index'
    get 'blogs/', to: 'blogs#index'
    get 'blogs/:id', to: 'blogs#show'

  end
  namespace :front do
    get 'tpl/:name.html' => 'home#templates'
    get 'tpl/:path1/:name.html' => 'home#templates'
    get 'tpl/:path1/:path2/:name.html' => 'home#templates'
  end
  namespace :api do
    scope :front, module: 'front' do
      post :logout
      post :change_password
      get :connect
      get :all_users
      get :all_shops
      get :all_groups
      get :all_tags
      post :api0
      post :api0_1
      get :api1
      get :api2
      get :api3
      get :api4
      post :api5
      post :api6
      get :api7
      get :api8
      post :api9
      post :api10
      get :api11
      get :api12
      post :api13
      post :api14
      post :api15
      get :api20
      get :api21
      get :api22
      get :api23
      post :api24
      get :api25
      get :api26
      get :api27
      get :api28
      get :api29
      post :api30
      get :api31
      get :api32
      post :api33
    end

    scope :admin, module: 'admin' do
      post :logout
      get :all_admins
      get :all_users
      get :all_shops
      get :all_groups
      get :all_tags
      post :api1
      get :api2
      get :api3
      post :api4
      get :api5
      post :api6
      post :api7
      get :api8
      get :api9
      get :api10
      post :api11
      post :api12
      post :api13
      get :api14
      get :api15
      post :api16
      get :api17
      post :api18
      get :api19
      get :api20
      post :api21
      get :api22
      post :api23
      post :api24
      get :api25
      get :api26
      get :api27
      post :api28
      post :api29
      get :api30
      get :api31
      get :api32
      post :api33
      post :api34
      get :api40
      get :api41
      get :api42
      get :api43
      get :api44
      get :api45
      get :api50
      get :api51
      post :api52
      get :api53
      post :api54
      post :api55
      get :api56
      post :api57
      get :api58
      get :api59
      get :api60
      post :api61
      post :api62
      post :api63
      post :api64
      get :api65
      get :api66
      get :api67
      get :api68
      get :api69
      get :api70
      get :api71
      post :api72
      post :api73

    end
    scope :group, module: 'group' do
      post :logout
      post :api1
      get :api2
      get :api3
      post :api4
      get :api5
      post :api6
      get :api7
      post :api8
      get :api9
      get :api10
      get :api11
      get :api12
      post :api13
      get :api14
      post :api15
      post :api16
      get :api17
      get :api18
      get :api19
      get :api20




      post :api21
      get :api22
      post :api23
      post :api24
      get :api25
      get :api26
      get :api27
      post :api28
      post :api29
      get :api30
      get :api31
      get :api32
      post :api33
      post :api34
      get :api40
      get :api41
      get :api42
      get :api43
      get :api44
      get :api45
      post :api46
    end

    scope :shop, module: 'shop' do
      post :logout
      post :api1
      get :api2
      get :api3
      post :api4
      get :api5
      get :api6
      get :api7
      get :api8
      post :api9
      get :api10
      post :api11
      post :api12
      get :api13
      get :api14
      get :api15
      get :api16
      post :api17
      get :api18
      post :api19
      get :api20

    end
  end

end
