require 'rails_helper'

RSpec.describe "CustomerSubscription API" do
  describe "create" do
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
      # binding.pry

      expect(new_subscription[:data]).to have_key(:id)
      expect(new_subscription[:data][:id]).to be_a(String)

      expect(new_subscription[:data][:attributes]).to have_key(:customer_id)
      expect(new_subscription[:data][:attributes][:customer_id]).to be_an(Integer)

      expect(new_subscription[:data][:attributes]).to have_key(:subscription_id)
      expect(new_subscription[:data][:attributes][:subscription_id]).to be_a(Integer)

      expect(new_subscription[:data][:attributes]).to have_key(:status)
      expect(new_subscription[:data][:attributes][:status]).to be_a(String)
    end
  end

  describe "#patch" do
    it "can update a customer subscription from active to 'inactive'" do
      customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins", email: "theshire@test.com", address: "Bag End, The Shire")
      
      subscription_1 = Subscription.create!(title: "Green Tea Bundle", price: 4999, frequency: 30)
      subscription_2 = Subscription.create!(title: "Black Tea Bundle", price: 4999, frequency: 60)
      subscription_3 = Subscription.create!(title: "Herbal Tea Bundle", price: 3999, frequency: 30)

      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Green'), subscription_id: subscription_1.id)
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Black'), subscription_id: subscription_2.id)

      new_sub1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: "active")
      new_sub2 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_2.id, status: "active")

      patch "/api/v1/customer_subscriptions/#{new_sub2.id}", params: { status: "inactive" }
      
      expect(response).to be_successful

      updated_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(updated_subscription[:data]).to have_key(:id)
      expect(updated_subscription[:data][:id]).to be_an(String)

      expect(updated_subscription[:data][:attributes]).to have_key(:customer_id)
      expect(updated_subscription[:data][:attributes][:customer_id]).to be_an(Integer)

      expect(updated_subscription[:data][:attributes]).to have_key(:subscription_id)
      expect(updated_subscription[:data][:attributes][:subscription_id]).to be_an(Integer)

      expect(updated_subscription[:data][:attributes]).to have_key(:status)
      expect(updated_subscription[:data][:attributes][:status]).to be_a(String)
    end
  end


  describe "it can display a list of all customer subscriptions BY customer" do
    it "can send a list of customer subscriptions for the specified customer" do
      customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins", email: "theshire@test.com", address: "Bag End, The Shire")
      customer_2 = Customer.create!(first_name: "Samwise", last_name: "Gamgee", email: "salt@test.com", address: "The Gaffer's Place, The Shire")
      
      subscription_1 = Subscription.create!(title: "Green Tea Bundle", price: 4999, frequency: 30)
      subscription_2 = Subscription.create!(title: "Black Tea Bundle", price: 4999, frequency: 60)
      subscription_3 = Subscription.create!(title: "Herbal Tea Bundle", price: 3999, frequency: 30)
  
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Green'), subscription_id: subscription_1.id)
      create_list(:tea, 3, title: Faker::Tea.variety(type: 'Black'), subscription_id: subscription_2.id)
  
      new_sub1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: "active")
      new_sub2 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_2.id, status: "active")
  
      new_sub3 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_1.id, status: "active")
      new_sub3 = CustomerSubscription.create!(customer_id: customer_2.id, subscription_id: subscription_2.id, status: "active")

      get '/api/v1/customer_subscriptions', params: { customer_id: customer_1.id }
  
      expect(response).to be_successful

      all_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(all_subscriptions[:data].count).to eq(2)
      expect(all_subscriptions[:data].first[:attributes]).to have_key(:customer_id)
      expect(all_subscriptions[:data].first[:attributes][:customer_id]).to eq(customer_1.id)
      expect(all_subscriptions[:data].last[:attributes][:customer_id]).to eq(customer_1.id)
    end  
  end
end

