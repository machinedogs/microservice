# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :events, only: [:index, :create]
    end
  end
end
