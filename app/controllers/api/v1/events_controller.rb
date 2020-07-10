# frozen_string_literal: true
class Api::V1::EventsController < ApplicationController
  skip_before_action :authenticate_host!, only: [:index]
  include JsonWebToken

  # Gets created events, pass in date, and get all the events for that dat
  def index
    #check params 
    @events = Event.all
    user_location = {latitude: params[:latitude], longitude: params[:longitude]}
    #Initially, we want to send events closest to them 
    @events = @events.select do |event|
      Geocoder::Calculations.distance_between([user_location[:latitude], user_location[:longitude]], [event.latitude, event.longitude])< 200
    end

    render :events, status: :ok
  end

  private

  def event_params
    params.permit(
      :title,
      :description,
      :date,
      :image,
      :category,
      :latitude,
      :longitude
    )
  end
end
