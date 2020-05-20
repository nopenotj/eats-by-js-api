class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.text :title
      t.string :description
      t.string :rating

      t.timestamps
    end
  end
end
