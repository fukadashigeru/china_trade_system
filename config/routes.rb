Rails.application.routes.draw do
  root to: 'orders#index' # root toはroutes.rbの末尾に記載する。
  devise_for :users
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
  resources :orders do
    collection do
      get :edit_all
      patch :update_all
      post :import
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
