class WorkshopDate < ApplicationRecord
  belongs_to :item
  has_many :order_items
end
