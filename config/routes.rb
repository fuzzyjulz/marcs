Rails.application.routes.draw do
    root 'home#index'
    resources :home, only: :index do
      get :become_a_member, :club_location, :club_rules, :faqs, on: :collection
    end
    resources :newsfeed, only: :index
    resources :albums, only: [:index, :show, :destroy] do
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
      get :edit, :home, :refresh, :trainers, :committee, :change_password
      patch :update_change_password
      resources :membership_years, only: [:create, :update, :show], path: "membership" do
        get :fees,:fees_back, :update_back
        post :admin_paid
        collection do
          get :renew
        end
      end
    end
    resources :users, only: [] do
      resources :membership_years, only: [:create], path: "membership" do
        collection do
          get :new_member_fees, :new_member_fees_saved
          post :new_member_fees, to: "membership_years#new_member_fees_create"
        end
      end
    end
    resources :membership_years, only: [:index], path: "membership" do
      patch :admin_paid, :admin_paid_revert
    end
    resources :membership_batches, only: [:show, :create], path: "batch" do
      collection do
        get :show
      end
    end
    resources :minutes, only: [:index,:show]
end
