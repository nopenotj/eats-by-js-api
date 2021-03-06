class Restaurant < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:title, :location], using: {
    tsearch: {
      prefix: true,
      dictionary: 'english'
    },
  }

    acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

    attribute :title
    attribute :description
    attribute :price

    validates :title, presence: true
    validates :price, numericality: { greater_than:0 }


    has_many :reviews, dependent: :destroy
    has_many :dishes, dependent: :destroy
    has_many :deals, dependent: :destroy
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
