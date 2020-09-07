class CreateWorkshopDates < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_dates do |t|
      t.references :item, null: false, foreign_key: true
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
