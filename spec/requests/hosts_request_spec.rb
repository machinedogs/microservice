# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hosts', type: :request do
  # Updates host profile
  describe 'Update Host profile' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      post '/api/v1/hosts', params: { 'profileImage': '', 'token': '' }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
  end
  # Tries to update hosy profile but fails
  describe 'Update Host profile but did not pass all the params' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      post '/api/v1/hosts', params: { 'profileImage': '' }
    end
    it 'returns http unprocessable entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Get profile image
  describe 'Get Host profile' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      get '/api/v1/hosts'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns expected response' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ 'profile' => 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500' })
    end
  end
end
