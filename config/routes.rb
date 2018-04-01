Rails.application.routes.draw do
  get 'entrypoint/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'webhook', to: 'entrypoint#index'
end
