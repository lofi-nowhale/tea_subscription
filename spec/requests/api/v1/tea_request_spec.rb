require 'rails_helper'

RSpec.describe "Tea Api" do
  describe "index" do
    it "sends a list of tea" do
      subscription1 = Subscription.create!(title: "The Green Bundle", price: 3999, frequency: 60 )
      create_list(:tea, 3, subscription_id: subscription1.id)

      get '/api/v1/teas'

      expect(response).to be_successful

      teas = JSON.parse(response.body, symbolize_names: true)

      expect(teas.count).to eq(3)

      tea = teas.first
      
      expect(tea).to have_key(:id)
      expect(tea[:id]).to be_an(Integer)
      
      expect(tea).to have_key(:title)
      expect(tea[:title]).to be_a(String)

      expect(tea).to have_key(:description)
      expect(tea[:description]).to be_a(String)
      
      expect(tea).to have_key(:temperature)
      expect(tea[:temperature]).to be_an(Integer)

      expect(tea).to have_key(:brew_time)
      expect(tea[:brew_time]).to be_an(Integer)
    end
  end
end