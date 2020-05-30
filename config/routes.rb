Rails.application.routes.draw do
  devise_for :users
  resources :user_forms do
    scope module: :user_forms do
      resource :user_form_messages, only: [:new, :create]
    end
  end
  root to: 'user_forms#index'
end
