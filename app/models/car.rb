class Car < ApplicationRecord
  validates :model, :carType, :price, :year, :horsePower, :seats, :doors, :transmission, :quantity, :image1, presence: true
end
