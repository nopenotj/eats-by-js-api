class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  validates :username, uniqueness: true, presence: true

  def isAdmin?
    true
  end
end
