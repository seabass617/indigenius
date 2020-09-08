class Item < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_many :workshop_dates
  has_many :orders, through: :order_items
  accepts_nested_attributes_for :workshop_dates
end
