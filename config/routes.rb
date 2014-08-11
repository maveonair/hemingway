Rails.application.routes.draw do
  get 'welcome/index'

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
