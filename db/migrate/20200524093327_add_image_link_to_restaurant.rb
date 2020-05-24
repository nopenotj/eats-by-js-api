class AddImageLinkToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :image_link, :string
  end
end
