Rails.application.routes.draw do
  # OAuth認証を開始するためのエンドポイント

  # OAuthプロバイダーからのコールバックを受け取るためのエンドポイント
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get "images/ogp.png", to: "images#ogp", as: "images_ogp"
  get "relationships/followees"
  get "relationships/followers"
  root "static_pages#top"
  resources :users, only: %i[new index create show] do
    member do
      get :liked_posts, :followees, :followers
    end
    resource :relationships, only: %i[create destroy]
  end
  resources :posts do
    resources :comments, only: %i[create edit destroy], shallow: true
    resource :likes, only: %i[create destroy]
    collection do
      get "category/:category_id", to: "posts#index", as: :category
      get :follow
    end
  end
  resources :categories, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :notifications, only: :index
  get "login" => "user_sessions#new"
  post "login" => "user_sessions#create"
  delete "logout" => "user_sessions#destroy"
  get "search", to: "search#search"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "contact", to: "static_pages#contact"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
