# frozen_string_literal: true
json.array! @event.going do |user|
        if Host.find(user)
                host = Host.find(user)
                json.profile host.profileImage
                json.name host.name
                json.email host.email
        else
                next
        end
end
