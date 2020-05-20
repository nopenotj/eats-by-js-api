class AddRestaurantToDishes < ActiveRecord::Migration[6.0]
  def change
    add_reference :dishes, :restaurant
  end
end
