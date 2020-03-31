Rails.application.routes.draw do
  devise_for :users
  resources :users
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions'   
  # } 

  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy" 
  # end
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

  root to: 'users#index' # root toはroutes.rbの末尾に記載する。

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
