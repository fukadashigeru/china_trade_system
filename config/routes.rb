Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    invitations:   'users/invitations',
                                    passwords:     'users/passwords',
                                    registrations: 'users/registrations'},
                     path: 'auth',
                     path_names: { sign_in: 'login',
                                   sign_out: 'logout',
                                   password: 'secret',
                                   confirmation: 'verification',
                                   unlock: 'unblock',
                                   registration: 'register',
                                   sign_up: 'cmon_let_me_in' }

  devise_scope :user do
    # get "sign_in", :to => "users/sessions#new"
    # get "sign_out", :to => "users/sessions#destroy"
    patch 'users/verification', to: 'users/confirmations#confirm'
    get "thanks", to: "users/registrations#thanks"
  end


  resources :articles
  resources :pictures
  resources :taobao_color_sizes, only: %i[new create edit update]
  resources :japanese_retailer_orders do
    collection do
      get :edit_all
      patch :update_all
      post :import
    end
  end
  resources :order_csv_imports, only: %i[index]
  resources :order_manual_inputs, only: %i[new create]
  resources :companies do
    collection do
      get :login
      get :logout
    end
  end
  resources :item_sets do
    collection do
      get :search
    end
  end
  resources :company_users
  resources :company_user_roles
  resources :search_companies
  resources :messages
  resources :company_connects
  resources :topics
  resources :connects
  resources :connect_offers
  resources :connect_authorizations
  resources :connect_deletes
  resources :chinese_buyer_orders
  resources :order_actual_item_units
  resources :set_pictures
  # root to: 'pages#index' # root toはroutes.rbの末尾に記載する。
  root to: 'users#index' # root toはroutes.rbの末尾に記載する。

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
