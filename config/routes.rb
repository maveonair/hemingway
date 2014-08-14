Rails.application.routes.draw do
  get 'welcome/index'
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :repositories do
    resources :runs, :only => :show do
      member do
        get :inspect
      end
    end

    member do
      post :start_run
    end
  end

  root 'welcome#index'

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
