class CreateRestaurantTagRs < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants_tags, id: false do |t|
      t.belongs_to :restaurant
      t.belongs_to :tag
    end
  end
end
