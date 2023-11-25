require 'rails_helper'

RSpec.describe "Customer API" do
  describe "index" do
    it "sends a list of customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_successful

      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers.count).to eq(3)

      customer = customers.first

      expect(customer).to have_key(:id)
      expect(customer[:id]).to be_an(Integer)
      
      expect(customer).to have_key(:first_name)
      expect(customer[:first_name]).to be_a(String)

      expect(customer).to have_key(:last_name)
      expect(customer[:last_name]).to be_a(String)
      
      expect(customer).to have_key(:email)
      expect(customer[:email]).to be_a(String)

      expect(customer).to have_key(:address)
      expect(customer[:address]).to be_a(String)
    end
  end
end