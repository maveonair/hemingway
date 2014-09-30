Rails.application.routes.draw do
  get 'welcome' => 'welcome#index', as: :welcome
  get "/auth/:provider/callback" => "sessions#create"
  get '/sessions/new'
  get "/signout" => "sessions#destroy", as: :sign_out

  resources :repositories, except: :new do
    get :code, :controller => 'runs', action: :show
    get 'code/:file_path' => 'runs', action: :inspect

    resources :runs, only: :show do
      member do
        get :inspect
      end
    end

    collection do
      get :settings
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
