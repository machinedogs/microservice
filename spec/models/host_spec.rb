# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Host, type: :model do
  describe 'Testing Host ' do
    it 'Takes all the expected attribues' do
      host = Host.create({ 'name': 'fake', 'email': 'fake123@gmail.com', 'password': 'fake123', 'password_confirmation': 'fake123' })
      expect(host.save).to eq(true)
    end

    it 'email not provided' do
      host = Host.create({ 'name': 'fake', 'email': '', 'password': 'fake123', 'password_confirmation': 'fake123' })
      expect(host.save).to eq(false)
    end

    it 'password match error' do
      host = Host.create({ 'name': 'fake', 'email': 'fake123@gmail.com', 'password': 'fak123', 'password_confirmation': 'fake123' })
      expect(host.save).to eq(false)
    end

    it 'short password' do
      host = Host.create({ 'name': 'fake', 'email': 'fake123@gmail.com', 'password': 'fak', 'password_confirmation': 'fak' })
      expect(host.save).to eq(false)
    end

    it 'incorrect email format' do
      host = Host.create({ 'name': '', 'email': 'fake123gmail.com', 'password': 'fake123', 'password_confirmation': 'fake123' })
      expect(host.save).to eq(false)
    end
  end
end
