class RemovePriceFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :price, :integer
  end
end
