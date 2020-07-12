# frozen_string_literal: true
class Api::V1::EventsController < ApplicationController
  skip_before_action :authenticate_host!, only: [:index]
  include JsonWebToken

  # Gets created events, pass in date, and get all the events for that dat
  def index
    #check params 
    @events = Event.all
    #if date and location given present
    if(params[:date] && params[:latitude] && params[:longitude] )
      #Get all events for that day
      @events = @events.select do |event|
        DateTime.parse(event.date).to_date == DateTime.parse(params[:date]).to_date
      end
      #Filter for the nearest events now
      @events = @events.select do |event|
        Geocoder::Calculations.distance_between([user_location[:latitude], user_location[:longitude]], [event.latitude, event.longitude])< 200
      end
      render :events, status: :ok
      #Given just location, filter events for that day
    elsif (params[:latitude] && params[:longitude])
      #Get all events for that day
      @events = @events.select do |event|
        DateTime.parse(event.date).to_date == DateTime.parse(params[:date]).to_date
      end
      #Filter all the events that are old, meaning time right now is more
      @events = @events.select do |event|
        DateTime.parse(event.date) > Time.now.iso8601
      end
      #Filter for the nearest events now
      @events = @events.select do |event|
        Geocoder::Calculations.distance_between([user_location[:latitude], user_location[:longitude]], [event.latitude, event.longitude])< 200
      end
      render :events, status: :ok
    elsif (params[:date])
      #Get all events for that day
      @events = @events.select do |event|
        DateTime.parse(event.date).to_date == DateTime.parse(params[:date]).to_date
      end
      render :events, status: :ok
      #Render all events for the future
    else 
      #Filter all the events that are old, meaning time right now is more
      # @events = @events.select do |event|
      #   DateTime.parse(event.date) > Time.now.iso8601
      # end
      render :events, status: :ok
    end
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
