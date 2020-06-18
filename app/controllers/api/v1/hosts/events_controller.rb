class Api::V1::Hosts::EventsController < ApplicationController
    include JsonWebToken

  # Create an event for a host
  def create
    # Get user
    @user = AuthorizeApiRequest.call(params).result
    @event = @user.event.create!(event_params)
    render :event, status: :ok
  rescue ActiveRecord::ActiveRecordError => e
    render json: {
      error: e.to_s
    }, status: :unprocessable_entity
  end

  # Update existing event
  def update
    user = AuthorizeApiRequest.call(params).result
    @event = user.event.find(params[:id])
    @event.update!(event_params)
    render :event, status: :ok
  rescue ActiveRecord::ActiveRecordError => e
    render json: {
      error: e.to_s
    }, status: :unprocessable_entity
  end

  # Gets created events, pass in date, and get all the events for that dat
  def index
    @user = AuthorizeApiRequest.call(params).result
    @host_events = Event.where(host_id: @user.id)
    render :host_events, status: :ok
  end

  # Destroys an event, will authenticate if this event belongs to this host, then deletes it
  def destroy
    # If invalid token, it will throw error in authorize api request call
    user = AuthorizeApiRequest.call(params).result
    if user.event.find(params[:id]).destroy
      render json: {
        status: 'Successful Deletion'
      }, status: :ok
    end
  # Error handling
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
    end

  # This endpoint is protected, and needs to authenticate user
  # This endpoint allows you to get all saved events of the host
  def host_saved_events
    user = AuthorizeApiRequest.call(params).result
    # Get the list of all saved events
    saved_events = user.saved_events
    @host_events = []
    # For all the saved events
    saved_events.each do |event_id|
      event = Event.find(event_id)
      @host_events.push(event)
    end
    render :host_events, status: :ok
  # Error handling
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end

  # Save an event to a host, pass event id
  def host_save_event
    # Get user
    user = AuthorizeApiRequest.call(params).result
    # update host
    if user.update(saved_events: user.saved_events.push(params[:event]))
      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
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

  def parse_string(string)
    string.gsub('images/', 'images%2F')
  end
end