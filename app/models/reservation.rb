class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :user_id, :car_id, :start_date, :end_date, :total, presence: true
  validate :validates_dates

  private

  def validates_dates
    if self.start_date >= self.end_date
      errors.add(:end_date, "can't be before the start day.")
    end
  end
end
