class AddColumnToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :location, :string
    add_column :restaurants, :operating_hours, :string
    add_column :restaurants, :no_of_stalls, :integer
    add_column :restaurants, :closed_on, :string
    add_column :restaurants, :contact, :string
  end
end
