class AddStateToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :state, :integer
  end
end
