# frozen_string_literal: true
class Api::V1::EventsController < ApplicationController
  skip_before_action :authenticate_host!, only: [:index]
  include JsonWebToken

  # Gets created events, pass in date, and get all the events for that dat
  def index
    @events = Event.all
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
