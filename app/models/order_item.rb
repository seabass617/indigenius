class OrderItem < ApplicationRecord
  belongs_to :workshop_dates
  belongs_to :items
  belongs_to :order
end
