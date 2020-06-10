class Dish < ApplicationRecord
    attribute :title , :text
    attribute :description , :string
    attribute :price , :float

    # Validations
    validates :title, presence: true
    validates :price, numericality: { greater_than: 0 }

    belongs_to :restaurant
end
