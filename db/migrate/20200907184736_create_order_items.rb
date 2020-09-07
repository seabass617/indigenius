class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :workshopDates, null: false, foreign_key: true
      t.references :items, null: false, foreign_key: true
      t.integer :quantity
      t.float :price
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
