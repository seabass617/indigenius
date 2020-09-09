class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates :status, inclusion: { in: [ 'completed', 'pending', 'cancelled' ] }
end