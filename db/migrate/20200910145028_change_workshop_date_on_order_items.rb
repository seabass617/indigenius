class ChangeWorkshopDateOnOrderItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :order_items, :workshop_date_id, true
  end
end
