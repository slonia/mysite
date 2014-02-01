Mysite::Application.routes.draw do
  devise_for :admins, path: '/admin'
  namespace :admin do
    resources :cathedras
  end
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'
end
