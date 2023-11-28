require 'rails_helper'

RSpec.describe 'Customer Subscription Serializer' do
  it "returns a JSON Customer Subscription in the correct format" do
    customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins", email: "theshire@test.com", address: "Bag End, The Shire")
    
    subscription_1 = Subscription.create!(title: "Green Tea Bundle", price: 4999, frequency: 30)
    subscription_2 = Subscription.create!(title: "Black Tea Bundle", price: 4999, frequency: 60)
    subscription_3 = Subscription.create!(title: "Herbal Tea Bundle", price: 3999, frequency: 30)

    create_list(:tea, 3, title: Faker::Tea.variety(type: 'Green'), subscription_id: subscription_1.id)
    create_list(:tea, 3, title: Faker::Tea.variety(type: 'Black'), subscription_id: subscription_2.id)

    new_sub1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: "active")
    new_sub2 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_2.id, status: "active")

    customer_subscription = CustomerSubscriptionSerializer.new(new_sub1).serializable_hash

    expected_format = {
      data: {
        id: new_sub1.id.to_s,
        type: :customer_subscription,
        attributes: {
          customer_id: customer_1.id,
          subscription_id: subscription_1.id,
          status: new_sub1.status
        }
      }
    }

    expect(customer_subscription).to eq(expected_format)
  end
end