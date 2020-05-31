# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :hosts,  :controllers => {:sessions => "host/sessions", :registrations => "host/registrations"} 

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index create]
      resources :events, only: %i[index create]
      resources :authentications, only: %i[create]
    end
  end

end
