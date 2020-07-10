# frozen_string_literal: true
class Api::V1::AttendingController < ApplicationController
    skip_before_action :authenticate_host!, only: [:index]
    include JsonWebToken

# Mark event as going 
  def create
    # Get user
    user = AuthorizeApiRequest.call(params).result
    #Find the event that they are try to mark as attending
    event = Event.find(params[:event_id])
    #See if event exists and does not belong to this host and user is not already going to it
    if (event && !user.event.exists?(params[:event_id]) && !event.going.include?(user.id.to_s))
        #Save the person as going to the event 
        if event.going == nil
            event.update!(going: [ user.id ] )
            render json: { status: 'success', data: event }, status: :ok
        elsif event.update!(going: event.going.push(user.id ))
            render json: { status: 'success', data: event }, status: :ok
        else
            render json: { status: 'error' }, status: :unprocessable_entity
        end
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end


  # Remove going for a person
  def destroy
    # Get user
    user = AuthorizeApiRequest.call(params).result
    event = Event.find(params[:event_id])
    #See if event is saved event for that user, if so remove it 
    if (event.going.include?(user.id.to_s) )
      event.update!(going: event.going-[user.id.to_s])
      render json: { status: 'success', data: event }, status: :ok
    else
      render json: {
        error: e.to_s
      }, status: :unprocessable_entity
    end
  end

  # Get all people going to an event 
  def index
    #Get the event
    @event = Event.find(params[:event_id])
    #Get the users going to the event
    if(params[:display_user]=="true")
      render :attendance, status: :ok
    else
      render json: { status: 'success', number_going: @event.going.length }, status: :ok
    end
rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
end
  