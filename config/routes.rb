Rails.application.routes.draw do
  resources :dashboard, only: :index
  resources :overlay, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  # Setting booleans on todos.
  patch 'todo/:id/promote', to: 'todo#promote', as: :todo_promote
  patch 'todo/:id/complete', to: 'todo#complete', as: :todo_complete
  patch 'todo/:id/delete', to: 'todo#delete', as: :todo_delete
end
