class AddRestaurantRefToDeals < ActiveRecord::Migration[6.0]
  def change
    add_reference :deals, :restaurant, null: false, foreign_key: true
  end
end
