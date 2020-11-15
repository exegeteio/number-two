# == Route Map
#
#                         Prefix Verb     URI Pattern                           Controller#Action
#                           root GET      /                                     home#root
#                dashboard_index GET      /dashboard(.:format)                  dashboard#index
#                  overlay_index GET      /overlay(.:format)                    overlay#index
#                   todo_promote PATCH    /todo/:id/promote(.:format)           todo#promote
#                  todo_complete PATCH    /todo/:id/complete(.:format)          todo#complete
#                    todo_delete PATCH    /todo/:id/delete(.:format)            todo#delete
# user_twitch_omniauth_authorize GET|POST /users/auth/twitch(.:format)          callbacks#passthru
#  user_twitch_omniauth_callback GET|POST /users/auth/twitch/callback(.:format) callbacks#twitch
#               new_user_session GET      /sign_in(.:format)                    redirect(301, /users/auth/twitch)
#           destroy_user_session GET      /sign_out(.:format)                   devise/sessions#destroy
#                    sidekiq_web          /sidekiq                              Sidekiq::Web

require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#root'
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

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
