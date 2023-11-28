class Api::V1::CustomerSubscriptionsController < ApplicationController 
  def create
    render json: CustomerSubscriptionSerializer.new(CustomerSubscription.create!(subscription_params))
  end

  def update
    @customer_sub = CustomerSubscription.find(params[:id])

    if @customer_sub.update(subscription_params)
      render json: CustomerSubscriptionSerializer.new(@customer_sub)
    end
  end
  
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.customer_subscriptions
    render json: CustomerSubscriptionSerializer.new(subscriptions)
  end

  private
  def subscription_params
    params.permit(:customer_id, :subscription_id, :status)
  end
end