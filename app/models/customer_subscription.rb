class CustomerSubscription < ApplicationRecord
  enum status: [:active, :inactive]

  belongs_to :customer
  belongs_to :subscription

  validates_presence_of :customer_id, :subscription_id, :status
end