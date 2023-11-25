class Subscription < ApplicationRecord
  validates_presence_of :title
  validates_numericality_of :price, :frequency

  has_many :teas

  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
end
