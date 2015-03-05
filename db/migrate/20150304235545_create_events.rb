class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :location
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :event_type
      t.text :details

      t.timestamps null: false
    end
  end
end
