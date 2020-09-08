class Order < ApplicationRecord
  belongs_to :user
  has_many :order_item
end
