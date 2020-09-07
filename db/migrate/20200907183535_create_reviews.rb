class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :items, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
