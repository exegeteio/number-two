# == Route Map
#

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # Root of the website.
  root 'home#index', as: :root

  # Overlay controller for displaying overlays in OBS or other streaming software.
  # Must not be authenticated.  Requires a channel parameter.
  get 'overlay/:channel', to: 'overlay#show', as: :overlay

  # Dashboard controller for a twitch creator to manage their stream.
  get 'dashboard/', to: 'dashboard#index', as: :dashboard

  # Patch back to update messages.
  resources :messages, only: %i[update destroy]

  # Setup devise.
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  devise_scope :user do
    # Dedicated redirects for sign in and out.
    get 'sign_in', to: redirect('/users/auth/twitch'), as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end
