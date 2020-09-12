Rails.application.routes.draw do
  resources :dashboard, only: :index
  resources :overlay, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'
end
