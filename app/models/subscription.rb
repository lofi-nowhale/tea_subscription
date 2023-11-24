class Subscription < ApplicationRecord
  validates_presence_of :title
  validates_numericality_of :price, :frequency

  has_many :teas
end
