# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :host
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :events, only: %i[index create hosts_events]
      resources :hosts, only: %i[index create]
      get '/host/events' => 'events#host_events', as: :host_events
    end
  end
end
