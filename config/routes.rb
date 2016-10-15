Rails.application.routes.draw do
    root 'home#index'
    resources :home, only: :index do
      get :become_a_member, :club_location, :faqs, on: :collection
    end
    resources :newsfeed, only: :index
    resources :albums, only: [:index, :show] do
      resources :photos, only: [:index]
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
