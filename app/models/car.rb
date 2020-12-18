class Car < ApplicationRecord
  validates :model, :carType, :price, :year, :horsePower, :seats, :doors, :transmission, :quantity, :imagesLink, presence :true
end
