# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Api::V1::Hosts::Events', type: :request do
  describe 'GET events for a authenticated host who has not hosted any events' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John Smith',
        "email": 'fakeemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)

      get '/api/v1/hosts/events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'JSON body response ' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end

  describe 'GET events for a authenticated host' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John Smith',
        "email": 'fakeemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      host.event.create!(event_object)
      host_result = double('host_result', result: host)

      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)

      get '/api/v1/hosts/events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'JSON body response ' do
      json_response = JSON.parse(response.body)
      expect(json_response.first['title']).to eq('Partyy')
      expect(json_response.first['description']).to eq('Come party yall')
      expect(json_response.first['date']).to eq('6-14-2020')
      expect(json_response.first['category']).to eq('category')
      expect(json_response.first['image']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['profile']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['name']).to eq('John Smith')
      expect(json_response.first['host']['email']).to eq('fakeemail@gmail.com')
      expect(json_response.first['location']['latitude']).to eq('39.9800')
      expect(json_response.first['location']['longitude']).to eq('-75.1600')
    end
  end

  describe 'Get events for a unauthorized host' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(false)
      get '/api/v1/hosts/events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  # Creating an event
  describe 'Creating an event' do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      event_object2 = {
        "title": "Let's party",
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      host.event.create!(event_object)
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      post '/api/v1/hosts/events', params: event_object2
      get '/api/v1/hosts/events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'host creates an event and returns expected response' do
      json_response = JSON.parse(response.body)
      expect(json_response.first['title']).to eq('Partyy')
      expect(json_response.first['description']).to eq('Come party yall')
      expect(json_response.first['date']).to eq('6-14-2020')
      expect(json_response.first['category']).to eq('category')
      expect(json_response.first['image']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['profile']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['name']).to eq('John')
      expect(json_response.first['host']['email']).to eq('fakemail@gmail.com')
      expect(json_response.first['location']['latitude']).to eq('39.9800')
      expect(json_response.first['location']['longitude']).to eq('-75.1600')

      # Second event
      expect(json_response.second['title']).to eq("Let's party")
      expect(json_response.second['description']).to eq('Come party yall')
      expect(json_response.second['date']).to eq('6-14-2020')
      expect(json_response.second['category']).to eq('category')
      expect(json_response.second['image']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.second['host']['profile']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.second['host']['name']).to eq('John')
      expect(json_response.second['host']['email']).to eq('fakemail@gmail.com')
      expect(json_response.second['location']['latitude']).to eq('39.9800')
      expect(json_response.second['location']['longitude']).to eq('-75.1600')
    end
  end

  describe 'Creating an event but not passed all required attributes' do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      post '/api/v1/events', params: event_object
    end
    it 'returns Active record error' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "Creating an event but unauthorized since user doesn't exist" do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(false)
      post '/api/v1/events'
    end
    it 'returns http unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'Deleting an event' do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      id = host.event.create!(event_object).id
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      url = '/api/v1/events/' + id.to_s
      delete url
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "Deleting an event that doesn't exist" do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      url = '/api/v1/events/4'
      delete url
    end
    it 'returns http not found' do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "Deleting an event that doesn't exist for a host" do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      url = '/api/v1/events/1'
      delete url
    end
    it 'returns http not found' do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'Deleting an event and verifying that the host does not have that event' do
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
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      id = host.event.create!(event_object).id
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      url = '/api/v1/events/' + id.to_s
      delete url
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'returns successful response' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ 'status' => 'Successful Deletion' })
    end
  end

  # Creating an event
  describe 'Save an event' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host_object2 = {
        "name": 'John Smith',
        "email": 'fakemail2@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host2 = Host.create(host_object2)
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      id = host.event.create!(event_object).id
      host_result = double('host_result', result: host2)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      get '/api/v1/host/save_event', params: { 'event': id.to_s }
      get '/api/v1/host/saved_events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'returns correct saved events for the user' do
      json_response = JSON.parse(response.body)
      expect(json_response.first['title']).to eq('Partyy')
      expect(json_response.first['description']).to eq('Come party yall')
      expect(json_response.first['date']).to eq('6-14-2020')
      expect(json_response.first['category']).to eq('category')
      expect(json_response.first['image']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['profile']).to eq('https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
      expect(json_response.first['host']['name']).to eq('John')
      expect(json_response.first['host']['email']).to eq('fakemail@gmail.com')
      expect(json_response.first['location']['latitude']).to eq('39.9800')
      expect(json_response.first['location']['longitude']).to eq('-75.1600')
    end
  end

  # Create an event, save it, then delete it, verify it is removed from saved events
  describe 'Save an event then it gets deleted afterwards' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host_object2 = {
        "name": 'John Smith',
        "email": 'fakemail2@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create(host_object)
      host2 = Host.create(host_object2)
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      id = host.event.create!(event_object).id
      host_result = double('host_result', result: host2)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)
      # Save an event
      get '/api/v1/host/save_event', params: { 'event': id.to_s }
      # Delete event
      host_result2 = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result2)
      url = '/api/v1/events/' + id.to_s
      delete url
      # Get Saved events
      get '/api/v1/host/saved_events'
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    it 'returns http success' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end

  # Update an event
  describe 'Update a hosts event' do
    before do
      allow(controller).to receive(:authenticate_host!).and_return(true)
      host_object = {
        "name": 'John',
        "email": 'fakemail@gmail.com',
        "password": 'fakepassword',
        "password_confirmation": 'fakepassword',
        "profileImage": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      }
      host = Host.create!(host_object)
      event_object = {
        "title": 'Partyy',
        "description": 'Come party yall',
        "date": '6-14-2020',
        "category": 'category',
        "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        "latitude": '39.9800',
        "longitude": '-75.1600'
      }
      id = host.event.create!(event_object).id
      host_result = double('host_result', result: host)
      allow(AuthorizeApiRequest).to receive(:call).and_return(host_result)

      url = '/api/v1/host/events/' + id.to_s
      put url
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    # it 'returns http success' do
    #   json_response = JSON.parse(response.body)
    #   expect(json_response).to eq([])
    # end
  end
end
