# frozen_string_literal: true

class Api::V1::HostsController < ApplicationController
  include JsonWebToken

  # Get profile image, need to be changed
  def index
    # Get user
    host = AuthorizeApiRequest.call(params).result

    # Get image uri
    if host
      render json: { profile: host[:profileImage] }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  # Put profile image, only that host can do this
  def create
    # Get user
    host = AuthorizeApiRequest.call(params).result
    image = '' + parse_string(params[:profileImage]) + '&token=' + params[:token]
    # Update their profile image
    if host.update(profileImage: image)
      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  rescue Exception => e # Never do this!
    render json: { status: 'error' }, status: :unprocessable_entity
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
