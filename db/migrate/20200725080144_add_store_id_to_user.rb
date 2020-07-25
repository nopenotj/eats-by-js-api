class AddStoreIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :restaurant
  end
end
