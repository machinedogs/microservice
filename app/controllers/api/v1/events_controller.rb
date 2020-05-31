# frozen_string_literal: true

require 'byebug'

class Api::V1::EventsController < ApplicationController # Create events
  def create
    event = Event.create(event_params)
    if event.save
      render json: { status: 'SUCCESS', message: 'Saved Event', data: event },
             status: :ok
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

  private

  def event_params
    params.permit(
      :host_name,
      :title,
      :description,
      :date,
      :type_id,
      :latitude,
      :longitude
    )
  end
end
