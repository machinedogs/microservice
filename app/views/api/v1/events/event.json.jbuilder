json.event do 
    json.event @event.id
    json.title @event.title
    json.description @event.description
    json.date @event.date
    json.image @event.image
    json.category @event.category
    json.location do
      json.longitude @event.longitude
      json.latitude @event.latitude
    end
    json.host do
      json.profile @event.host.profileImage
      json.name @event.host.name
      json.email @event.host.email
    end
end