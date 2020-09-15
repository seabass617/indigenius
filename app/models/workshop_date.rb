class WorkshopDate < ApplicationRecord
  belongs_to :item
  has_many :order_items

  def formated_string
    "#{start_date} to #{end_date}"
  end
  
end
