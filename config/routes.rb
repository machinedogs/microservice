# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :host
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :events, only: %i[index]
      resources :hosts, only: %i[index create]
      namespace :hosts, defaults: { format: :json } do
        resources :events, only: %i[index create update destroy], controller: 'events'
        get '/saved_events' => 'events#host_saved_events'
        get '/save_event' => 'events#host_save_event'
      end
    end
  end
end
