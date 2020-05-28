class AddHalalCertifiedToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :halal_certified, :boolean
  end
end
