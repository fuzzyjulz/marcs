Rails.application.routes.draw do
    root 'home#index'
    get 'home' => 'home#index'
    get 'newsfeed' => 'newsfeed#view'
    
    
    devise_for :users, :controllers => { :sessions => "api/v1/sessions" }
    devise_scope :user do
      namespace :api do
        namespace :v1 do
          resources :sessions, :only => [:create]
        end
      end
      get '/users/sign_out' => 'api/v1/sessions#destroy'
    end
    resource :user do
      get :edit, :home
      post :update
    end
end
