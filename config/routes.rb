Rails.application.routes.draw do
    root 'home#index'
    resources :home, only: :index do
      get :become_a_member, :club_location, :club_rules, :faqs, on: :collection
    end
    resources :newsfeed, only: :index
    resources :albums, only: [:index, :show] do
      resources :photos, only: [:index]
      get :refresh
    end
    resources :calendar_events, only: :index
    
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
      get :edit, :home, :refresh, :trainers, :committee
      post :update
      resources :membership_years, only: [:create, :update, :show], path: "membership" do
        get :fees,:fees_back, :update_back
        post :admin_paid
        collection do
          get :renew
        end
      end
    end
    resources :membership_years, only: [:index], path: "membership" do
      patch :admin_paid
    end
    resources :minutes, only: [:index,:show]
end
