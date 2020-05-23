class DropAccesstoken < ActiveRecord::Migration[6.0]
  def change
    drop_table :access_tokens
  end
end
