# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# We can use this file to populate the database

# Creates User
# object = {
#   "name": 'John Smith',
#   "email": 'John@gmail.com',
#   "password": 'FakePassword123',
#   "saved_events": [],
#   "created_events": []
# }
# user = User.create(object)

# Create a host
host_object = {
  "name": 'John Smith',
  "email": 'fakeemail@gmail.com',
  "password": 'fakepassword',
  "password_confirmation": 'fakepassword'
}
host_object2 = {
  "name": 'John Lu',
  "email": 'fakeemail2@gmail.com',
  "password": 'fakepassword',
  "password_confirmation": 'fakepassword'
}

host = Host.create!(host_object)
host2 = Host.create!(host_object2)
# Creates Event for host 1
event_object = {
  "title": 'Partyy',
  "description": 'Come party yall',
  "date": '6-14-2020',
  "category": 'category',
  "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  "latitude": '39.9800',
  "longitude": '-75.1600'
}

# Creates event for host 2
event_object2 = {
  "title": 'Partyy at my house',
  "description": 'Come party yall',
  "date": '6-14-2020',
  "category": 'category',
  "image": 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  "latitude": '39.9800',
  "longitude": '-75.1600'
}

# Associates the host to this event
host.event.create!(event_object)

host2.event.create!(event_object2)
