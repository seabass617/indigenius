class OrderItem < ApplicationRecord
  belongs_to :workshop_date, optional: true
  belongs_to :item
  belongs_to :order
  monetize :price_cents
end
