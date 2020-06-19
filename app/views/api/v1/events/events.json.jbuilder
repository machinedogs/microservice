# frozen_string_literal: true

json.array! @events do |event|
  json.event event.id
  json.title event.title
  json.description event.description
  json.date event.date
  json.image event.image
  json.category event.category
  json.location do
    json.longitude event.longitude
    json.latitude event.latitude
    json.address Geocoder.search(event.latitude.to_s + ',' + event.longitude.to_s)&.first&.address
  end
  json.host do
    json.profile event.host.profileImage
    json.name event.host.name
    json.email event.host.email
  end
end
