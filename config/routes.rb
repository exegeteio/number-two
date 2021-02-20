# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # Root of the website.
  root 'home#index', as: :root

  # Overlay controller for displaying overlays in OBS or other streaming software.
  # Must not be authenticated.  Requires a channel parameter.
  get 'overlay/:channel', to: 'overlay#show', as: :overlay
end
