class AddCoordinatesToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
  end
end
