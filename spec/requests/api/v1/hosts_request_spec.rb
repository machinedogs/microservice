require "rails_helper"

RSpec.describe "Api::V1::Hosts", type: :request do
#   describe "GET " do
#     before do
#       get "/api/v1/events"
#     end
#     it "returns http success" do
#       expect(response).to have_http_status(:ok)
#     end
#     it "JSON body response " do
#       json_response = JSON.parse(response.body)
#       expect(json_response).to eq([])
#     end
#   end

#   describe "GET one event" do
#     before do
#       host_object = {
#         "name": "John Smith",
#         "email": "fakeemail@gmail.com",
#         "password": "fakepassword",
#         "password_confirmation": "fakepassword",
#         "profileImage": "https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
#       }
#       host = Host.create(host_object)
#       event_object = {
#         "title": "Partyy",
#         "description": "Come party yall",
#         "date": "6-14-2020",
#         "category": "category",
#         "image": "https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
#         "latitude": "39.9800",
#         "longitude": "-75.1600",
#       }
#       host.event.create!(event_object)
#       get "GET /api/v1/events"
#     end
#     it "returns http success" do
#       expect(response).to have_http_status(:ok)
#     end
#     it "JSON returns expected json response " do
#       json_response = JSON.parse(response.body)

#       expect(json_response.first["title"]).to eq("Partyy")
#       expect(json_response.first["description"]).to eq("Come party yall")
#       expect(json_response.first["date"]).to eq("6-14-2020")
#       expect(json_response.first["category"]).to eq("category")
#       expect(json_response.first["image"]).to eq("https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
#       expect(json_response.first["host"]["profile"]).to eq("https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
#       expect(json_response.first["host"]["name"]).to eq("John Smith")
#       expect(json_response.first["host"]["email"]).to eq("fakeemail@gmail.com")
#       expect(json_response.first["location"]["latitude"]).to eq("39.9800")
#       expect(json_response.first["location"]["longitude"]).to eq("-75.1600")
#     end
#   end
end
