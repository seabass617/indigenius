class RemovePriceFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :price, :float
  end
end
