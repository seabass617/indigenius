class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.string :category
      t.integer :capacity
      t.integer :quantity
      t.boolean :workshop

      t.timestamps
    end
  end
end
