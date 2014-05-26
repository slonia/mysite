Mysite::Application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admins, path: '/admin'
  get '/admin', to: 'admin/admin#index', as: :admin_page

  namespace :admin do
    resources :cathedras
    resources :teachers
    resources :rooms, except: :show
    resources :subjects
    resources :groups, except: :show do
      get :short_edit, on: :member
    end
    resources :tweet_logs, only: [:index, :show, :destroy] do
      member do
        get :mark_good
        get :mark_bad
      end
    end
  end

  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  resources :groups, only: [:index, :show]
  root to: 'groups#index'

  namespace :api do
    resources :subjects, only: :show do
      get :teachers, on: :member
      get :for_term, on: :collection
    end
  end
end
