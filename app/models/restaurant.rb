class Restaurant < ApplicationRecord
    attribute :title
    attribute :description
    attribute :price
    attribute :rating


    has_many :reviews
    has_many :dishes, dependent: :destroy
    has_and_belongs_to_many :tags 

    def rating 
      all_reviews = self.reviews
      sum = all_reviews.map{|x| x.rating}.reduce(:+) 
      if sum.nil? 
        -1
      else
        count = all_reviews.count.to_f
        sum / count
      end
    end
end
