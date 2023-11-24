require 'rails_helper'

RSpec.describe "Subscription API" do
  describe "index" do
    it "sends a list of available subscriptions" do
      create_list(:subscription, 4)

      get '/api/v1/subscriptions'


      expect(response).to be_successful

      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions.count).to eq(4)
      
      subscription = subscriptions.first
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_an(Integer)

      expect(subscription).to have_key(:title)
      expect(subscription[:title]).to be_a(String)

      expect(subscription).to have_key(:price)
      expect(subscription[:price]).to be_an(Integer)
      expect(subscription).to have_key(:frequency)
    end
  end

end