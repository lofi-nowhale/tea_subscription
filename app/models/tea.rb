class Tea < ApplicationRecord
  validates_presence_of :title, :description
  validates_numericality_of :temperature, :brew_time

  belongs_to :subscription
end
