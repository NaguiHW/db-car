class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :carType
      t.string :price
      t.string :year
      t.string :horsePower
      t.string :seats
      t.string :doors
      t.string :transmission
      t.string :quantity
      t.string :imagesLink, array: true, default: []

      t.timestamps
    end
  end
end
