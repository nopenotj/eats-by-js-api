class User < ApplicationRecord

  # USER_ROLES
  # 0 - normal user
  # 1 - restaurant owners
  # 2 - admin users

  has_secure_password
  has_many :reviews
  validates :username, uniqueness: true, presence: true
  validates :role, numericality: true, presence: true

  def isAdmin?
    # role == 2
    true
  end
end
