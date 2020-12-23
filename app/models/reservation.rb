class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :user_id, :car_id, :start_date, :end_date, :total, presence: true
end
