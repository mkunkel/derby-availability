class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :phone_number
      t.string :resume_url
      t.integer :insurance_id

      t.timestamps null: false
    end
  end
end
