class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true

  validates_numericality_of :rating, integer:true, greater_than_or_equal: 0, less_than_or_equal_to: 5
end
