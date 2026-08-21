  Rails.application.routes.draw do

  get "/health", to: proc { [200, {}, ['OK']] }

  Rails.application.routes.draw do
    root "user#index"
    # root "sessions#create"
  end

  resources :user, only: [:create, :show]

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "up" => "rails/health#show", as: :rails_health_check
end
