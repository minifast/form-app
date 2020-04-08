Rails.application.routes.draw do
  get 'user_form/new'
  resources :user_forms

  root to: 'user_form#new'
end
