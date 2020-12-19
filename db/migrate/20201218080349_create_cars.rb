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
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :image4
      t.string :image5

      t.timestamps
    end
  end
end
