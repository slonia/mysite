Mysite::Application.routes.draw do

  devise_for :admins, path: '/admin'
  get '/admin', to: 'admin/admin#index', as: :admin_page

  namespace :admin do
    resources :cathedras
    resources :teachers
    resources :rooms, except: :show
    resources :subjects
    resources :groups, except: :show
  end

  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :groups, only: [:index, :show]
  root to: 'groups#index'
end
