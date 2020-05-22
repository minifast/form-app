Rails.application.routes.draw do
  devise_for :users
  resources :user_forms

  root to: 'user_forms#index'
end
