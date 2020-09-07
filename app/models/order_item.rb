class OrderItem < ApplicationRecord
  belongs_to :workshopDates
  belongs_to :items
  belongs_to :order
end
