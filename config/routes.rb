Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :dashboard, only: :index
  resources :overlay, only: :index

  # Setting booleans on todos.
  patch 'todo/:id/promote', to: 'todo#promote', as: :todo_promote
  patch 'todo/:id/complete', to: 'todo#complete', as: :todo_complete
  patch 'todo/:id/delete', to: 'todo#delete', as: :todo_delete

  # Setup devise.
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  devise_scope :user do
    get 'sign_in', to: redirect('/users/auth/twitch'), as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end
