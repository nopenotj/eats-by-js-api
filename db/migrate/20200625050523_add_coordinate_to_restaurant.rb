class AddCoordinateToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :lng, :decimal, precision: 10, scale: 6
    add_column :restaurants, :lat, :decimal, precision: 10, scale: 6
    add_index :restaurants, [:lat, :lng]
  end
end
