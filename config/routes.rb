Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index', as: :welcome
  get '/sessions/new'
  get '/logout', to: 'sessions#destroy', as: :logout

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

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
