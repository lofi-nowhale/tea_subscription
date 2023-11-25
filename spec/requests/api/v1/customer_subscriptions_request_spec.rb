require 'rails_helper'

RSpec.describe "CustomerSubscription API" do
  describe "index" do
    it "can create a CustomerSubscription" do
      customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins", email: "theshire@test.com", address: "Bag End, The Shire")
      
      subscription_1 = Subscription.create!(title: "Green Tea Bundle", price: 4999, frequency: 30)
      subscription_2 = Subscription.create!(title: "Black Tea Bundle", price: 4999, frequency: 60)
      subscription_3 = Subscription.create!(title: "Herbal Tea Bundle", price: 3999, frequency: 30)

      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Green'), subscription_id: subscription_1.id)
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Black'), subscription_id: subscription_2.id)
    
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Herbal'), subscription_id: subscription_3.id)
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Green'), subscription_id: subscription_1.id)

      c1_subscription_1 = {
        customer_id: customer_1.id, 
        subscription_id: subscription_1.id, 
        status: "active"
      }
      
      post "/api/v1/customer_subscriptions", params: c1_subscription_1

      expect(response).to be_successful
      
      new_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(new_subscription).to have_key(:id)
      expect(new_subscription[:id]).to be_an(Integer)

      expect(new_subscription).to have_key(:customer_id)
      expect(new_subscription[:customer_id]).to be_an(Integer)

      expect(new_subscription).to have_key(:subscription_id)
      expect(new_subscription[:subscription_id]).to be_an(Integer)

      expect(new_subscription).to have_key(:status)
      expect(new_subscription[:status]).to be_a(String)
    end
  end
end

