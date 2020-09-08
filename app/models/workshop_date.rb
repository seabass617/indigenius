class WorkshopDate < ApplicationRecord
  belongs_to :items
  has_many :order_items
end
