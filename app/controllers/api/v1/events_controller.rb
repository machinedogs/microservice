# frozen_string_literal: true


class Api::V1::EventsController < ApplicationController
  skip_before_action :authenticate_host!, only: [:index]
  include JsonWebToken
  #Create an event, need to be authenticated, and associate this event to this host 
  #Decode the jwt to get the host, and create the event for that host 
  def create
    #Get user
    @user = AuthorizeApiRequest.call(params).result
    @event = @user.event.create(event_params)
    if @event.save
      render :event, status: :ok
    else
      render json: {
        status: 'ERROR', message: 'Event Not Saved', data: event.errors
      },
             status: :unprocessable_entity
    end
  end

  # Gets created events
  def index
    @events = Event.all
    render :events, status: :ok
  end

  #This endpoint is protected, and needs to authenticate user
  def host_events
    @user = AuthorizeApiRequest.call(params).result
    @host_events = Event.where(host_id: @user.id)
    render :host_events, status: :ok
  end

  #Destroys an event, will authenticate if this event belongs to this host, then deletes it
  def destroy
    #If invalid token, it will throw error in authorize api request call
    user = AuthorizeApiRequest.call(params).result
    if user.event.find(params[:id]).destroy
      render json: {
        status: 'Successful Deletion'
      }, status: :ok
    else
      render json: {
        status: 'ERROR', message: 'Event could not be deleted ', data: event.errors
      }, status: :forbidden
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
