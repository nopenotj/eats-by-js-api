class RestaurantRequest < ApplicationRecord
    attribute :title
    attribute :description
    attribute :price

    validates :title, presence: true
    validates :price, numericality: { greater_than:0 }
end
