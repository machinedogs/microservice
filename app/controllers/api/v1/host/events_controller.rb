
class Api::V1::Host::EventsController < ApplicationController
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
  #Clean up
  def host_saved_events
    user = AuthorizeApiRequest.call(params).result
    # Get the list of all saved events
    saved_events = user.saved_events
    if(saved_events == nil)
      saved_events = []
    end
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
  rescue Exception => e
    render json: {
      error: e.to_s
    }, status: :unprocessable_entity
  end

  # Save an event to a host, pass event id
  def host_save_event
    # Get user
    user = AuthorizeApiRequest.call(params).result
    #See if event exists and does not belong to this host
    if (Event.find(params[:event]) && !user.event.exists?(params[:event]) && !user.saved_events.include?(params[:event]))
      # save event
      if user.saved_events == nil
        user.update!(saved_events: [ params[:event] ] )
        render json: { status: 'success' }, status: :ok
      elsif user.update!(saved_events: user.saved_events.push(params[:event]))
        render json: { status: 'success' }, status: :ok
      else
        render json: { status: 'error' }, status: :unprocessable_entity
      end
    else
      render json: {
        error: e.to_s
      }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
  # Save an event to a host, pass event id
  def delete_saved_event
    # Get user
    user = AuthorizeApiRequest.call(params).result
    #See if event is saved event for that user, if so remove it 
    if (user.saved_events.include?(params[:event]) )
      user.update!(saved_events: user.saved_events-[params[:event].to_s])
      render json: { status: 'success' }, status: :ok
    else
      render json: {
        error: e.to_s
      }, status: :unprocessable_entity
    end
  end

  def attending
    #Get user
    user = AuthorizeApiRequest.call(params).result
    #Get all the events
    @events = Event.all
    #Filter based on the events that this user is attending
    @events = @events.select do |event|
      event.going.include?(user.id.to_s)
    end
    render :attending_events, status: :ok
  end

  private

  def event_params
    param = params.permit(
      :title,
      :description,
      :date,
      :image,
      :category,
      :latitude,
      :longitude
    )
    param[:address]= Geocoder.search(params[:latitude].to_s + ',' + params[:longitude].to_s)&.first&.address
    return param
  end

  def parse_string(string)
    string.gsub('images/', 'images%2F')
  end
end
