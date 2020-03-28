Rails.application.routes.draw do
  get 'hello_world/index'

  root to: 'hello_world#index'
end
