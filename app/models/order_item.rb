class OrderItem < ApplicationRecord
  belongs_to :workshoDates
  belongs_to :items
  belongs_to :order
end
