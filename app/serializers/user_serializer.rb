class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :username
    attributes :role
    attributes :is_admin, &:isAdmin?
    has_many :reviews
  end
