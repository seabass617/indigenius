class Item < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :workshop_dates, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  has_many_attached :images
  accepts_nested_attributes_for :workshop_dates
  #monetize :price_cents

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  

  include PgSearch::Model
  pg_search_scope :search_by_name_category_and_description,
    against: [ :name, :category, :description ],
    using: {
      tsearch: { prefix: true } 
    }
end
