class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.boolean :share_email
      t.boolean :share_phone_number
      t.boolean :share_resume_url
      t.boolean :share_profile

      t.timestamps null: false
    end
  end
end
