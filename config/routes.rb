Rails.application.routes.draw do
  get 'welcome' => 'welcome#index', as: :welcome
  get "/auth/:provider/callback" => "sessions#create"
  get '/sessions/new'
  get "/signout" => "sessions#destroy", as: :sign_out

  resources :repositories do
    resources :runs, only: :show do
      member do
        get :inspect
      end
    end

    member do
      post :start_run
    end
  end

  root 'repositories#index'

  if Rails.env.development?
    require 'sidekiq/web'
    mount(Sidekiq::Web => '/sidekiq')
  end
end
