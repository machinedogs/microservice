# frozen_string_literal: true
json.array! @event.going do |user|
        host = Host.find(user)
        json.profile host.profileImage
        json.name host.name
        json.email host.email
end
