class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :user_id, :car_id, :startDate, :endDate, :total, presence: true
end
