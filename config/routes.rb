Rails.application.routes.draw do
    root 'homes#index'
    get 'home' => 'homes#index'
    get 'newsfeed' => 'newsfeed#view'
    resource :home do
      get :become_a_member, :club_location
    end
    
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
      get :edit, :home, :refresh
      post :update
    end
end
