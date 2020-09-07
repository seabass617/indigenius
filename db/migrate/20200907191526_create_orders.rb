class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :User, null: false, foreign_key: true
      t.string :status
      t.integer :TotalPrice

      t.timestamps
    end
  end
end
