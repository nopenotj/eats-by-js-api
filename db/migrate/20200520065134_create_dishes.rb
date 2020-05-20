class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.text :title
      t.string :description
      t.string :price

      t.timestamps
    end
  end
end
