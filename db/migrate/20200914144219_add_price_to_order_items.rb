class AddPriceToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_monetize :order_items, :price, currency: { present: false }
  end
end
