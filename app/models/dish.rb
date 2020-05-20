class Dish < ApplicationRecord
    attribute :title , :text
    attribute :description , :string
    attribute :price , :float

    belongs_to :restaurant
end
