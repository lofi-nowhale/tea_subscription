class Api::V1::CustomerSubscriptionsController < ApplicationController 
  def create
    render json: CustomerSubscription.create!(subscription_params)
  end

  def update
    binding.pry

  end
  
  def index
    render json: CustomerSubscription.all
  end

  private
  def subscription_params
    params.permit(:customer_id, :subscription_id, :status)
  end
end