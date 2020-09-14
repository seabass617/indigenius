class Item < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_many :workshop_dates, dependent: :destroy
  has_many :orders, through: :order_items
  has_many_attached :images
  accepts_nested_attributes_for :workshop_dates

  attr_accessor :additional_params
end
