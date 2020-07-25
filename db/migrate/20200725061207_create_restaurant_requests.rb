class CreateRestaurantRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurant_requests do |t|
      t.text :title
      t.string :description
      t.string :price
      t.string :image_link
      t.string :location
      t.string :operating_hours
      t.integer :no_of_stalls
      t.string :closed_on
      t.string :contact
      t.boolean :halal_certified
      t.integer :state
      t.decimal :lng, precision: 10, scale: 6
      t.decimal :lat, precision: 10, scale: 6
      t.index [:lat, :lng]

      t.timestamps
    end
  end
end
