# frozen_string_literal: true
json.attendance do
    @event.going.each do |user| 
        host = Host.find(user)
        json.user do
            json.profile host.profileImage
            json.name host.name
            json.email host.email
          end
    end
end