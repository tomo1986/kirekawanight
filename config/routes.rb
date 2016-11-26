Rails.application.routes.draw do
  devise_for :groups
  devise_for :admins
  devise_for :customers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'front/home#index'


  namespace :admin do
    root to: 'pages#index', via: :get
    devise_for :admins, path_prefix: '/admin',controllers: {},:skip => [:sessions,:passwords]
    as :admin do
      match '/sign_out' => 'sessions#destroy', :as => :destroy_admin_session,
            :via => Devise.mappings[:admin].sign_out_via
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
    get 'logout', to: 'home#logout'
    get 'mypage',to: 'home#index'
    get 'mypage/edit', to: 'home#index'


    get 'casts/karaoke', to: 'home#cast_karaoke'
    get 'casts/karaoke/:id', to: 'home#index'

    get 'groups/karaoke', to: 'home#group_karaoke'
    get 'groups/karaoke/:id', to: 'home#index'


    get 'casts/bar', to: 'home#cast_bar'
    get 'casts/bar/:id', to: 'home#index'

    get 'groups/bar', to: 'home#group_bar'
    get 'groups/bar/:id', to: 'home#index'

    get 'casts/massage', to: 'home#cast_massage'
    get 'casts/massage/:id', to: 'home#index'

    get 'groups/massage', to: 'home#group_massage'
    get 'groups/massage/:id', to: 'home#index'

    get 'casts/sexy', to: 'home#cast_sexy'
    get 'casts/sexy/:id', to: 'home#index'

    get 'system', to: 'home#index'
    get 'comsept', to: 'home#index'
    get 'question', to: 'home#index'
    get 'visitor', to: 'home#index'
    get 'contact', to: 'home#index'
    get 'reserve', to: 'home#index'
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
      get :api0
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
    end

    scope :admin, module: 'admin' do
      post :api1
      get :api2
      get :api3
      post :api4
      get :api5
      post :api6
      get :api7
      get :api8
      get :api9
      get :api10
      post :api11
      get :api12
      post :api13
      get :api14
      get :api15
      get :api16
      post :api17
      get :api18
      get :api19
      post :api20
      get :api21
      post :api22
      get :api23
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
    end
  end

end
