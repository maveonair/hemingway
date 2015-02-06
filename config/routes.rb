Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index', as: :welcome
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sessions/new'
  get "/logout" => "sessions#destroy", as: :logout

  resources :repositories do
    resources :runs, only: :show do
      member do
        get :inspect
      end
    end

    collection do
      get :choose_account
    end

    member do
      get :settings
      post :start_run
    end
  end

  root 'repositories#index'

  if Rails.env.development?
    require 'sidekiq/web'
    mount(Sidekiq::Web => '/sidekiq')
  end
end
