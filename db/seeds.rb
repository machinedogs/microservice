# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# We can use this file to populate the database 

#Creates User
object = {
    "name": "John Smith",
    "email": "John@gmail.com",
    "password": "FakePassword123",
    "saved_events": [],
    "created_events": []
}
user = User.create(object)

#Creates Event 
event_object = {
    "user_id": "1",
    "title": "Partyy",
    "description": "Come party yall",
    "date": "",
    "type_id": "1",
    "latitude": "39.9800",
    "longitude": "-75.1600"
}
event = Event.create(event_object)

