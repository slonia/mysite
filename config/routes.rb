Mysite::Application.routes.draw do
  devise_for :admins, path: '/admin'
  get '/admin', to: 'admin/admin#index', as: :admin_page
  namespace :admin do
    resources :cathedras
    resources :teachers
  end
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'
end
