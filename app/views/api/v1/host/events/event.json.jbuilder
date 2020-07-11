# frozen_string_literal: true

json.event do
  next if @event&.host.nil?

  json.event @event.id
  json.title @event.title
  json.description @event.description
  json.date @event.date
  json.image @event.image
  json.category @event.category
  json.attending @event.going
  json.location do
    json.longitude @event.longitude
    json.latitude @event.latitude
    json.address @event.address
  end
  json.host do
    json.profile @event.host.profileImage
    json.name @event.host.name
    json.email @event.host.email
  end
end
