Rails.application.routes.draw do
  # Rotas da área administrativa
  namespace :admin do
    root "dashboard#index" # /admin
    resources :reservations, only: [:index, :show]
    resources :availabilities, only: [:index, :new, :create, :edit, :update]
    resources :batteries, only: [:index, :new, :create, :edit, :update]
  end

  # Rotas públicas (clientes)
  resources :reservations, only: [:new, :create, :show]
  resources :availabilities, only: [:index]
  resources :users, only: [:new, :create]

  # Hotwire Native (mantido conforme sua configuração)
  draw(:hotwire_native)

  # Verificação de status da aplicação
  get "up" => "rails/health#show", as: :rails_health_check

  # Página inicial
  root "reservations#new"
end
