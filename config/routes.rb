# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :host
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :events, only: %i[index]
      namespace :host, defaults: { format: :json } do
        resources :events, only: %i[index create update destroy], controller: 'events'
        resources :profiles, only: %i[index create]
        get '/saved_events' => 'events#host_saved_events'
        get '/save_event' => 'events#host_save_event'
      end
    end
  end
end
