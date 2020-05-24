class Restaurant < ApplicationRecord
    attribute :title
    attribute :description
    attribute :price
    attribute :rating


    has_many :reviews
    has_many :dishes, dependent: :destroy
    has_and_belongs_to_many :tags 
end
