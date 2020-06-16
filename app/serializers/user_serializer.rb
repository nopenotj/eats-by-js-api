class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :username
    attributes :role
    has_many :reviews
  end
