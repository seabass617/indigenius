class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :delete_all
  validates :status, inclusion: { in: [ 'confirmed', 'pending', 'cancelled' ] }
  monetize :total_price_cents
end
