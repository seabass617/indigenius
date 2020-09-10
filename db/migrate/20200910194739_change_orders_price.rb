class ChangeOrdersPrice < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :total_price, :float
  end
end
