class Tag < ApplicationRecord
    attribute :title, :string

    validates :name, uniqueness: true 

    has_and_belongs_to_many :restaurants
end
