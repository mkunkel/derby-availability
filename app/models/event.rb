class Event < ActiveRecord::Base
  has_many :events_users
  has_many :users, through: :events_users
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :event_type, presence: true
  validates :details, presence: true
end
