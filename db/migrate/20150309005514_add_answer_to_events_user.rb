class AddAnswerToEventsUser < ActiveRecord::Migration
  def change
    add_column :events_users, :answer, :string
  end
end
