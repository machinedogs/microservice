# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :host
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :events, only: %i[index create destroy ]
      resources :hosts, only: %i[index create]
      get '/host/events' => 'events#host_events', as: :host_events
      get '/host/saved_events' => 'events#host_saved_events', as: :host_saved_events
      get '/host/save_event' => 'events#host_save_event', as: :host_save_event
    end
  end
end
