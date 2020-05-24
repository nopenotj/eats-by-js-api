class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :username
  end
