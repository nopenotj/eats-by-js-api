class Restaurant < ApplicationRecord
  include Rails.application.routes.url_helpers
    attribute :title
    attribute :description
    attribute :price
    attribute :rating


    def image_link
      polymorphic_url(self.pictures.first, :only_path => true)
    end

    has_many_attached :pictures
    has_many :dishes, dependent: :destroy
    has_and_belongs_to_many :tags 
end
