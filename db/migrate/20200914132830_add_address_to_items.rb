class AddAddressToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :address, :string
  end
end
