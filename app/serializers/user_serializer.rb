class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :username
    attributes :role
    attributes :is_admin, &:isAdmin?
    has_many :reviews

    attributes :restaurant_id ,if: Proc.new { |record, params|
      pp record
      record.role == 1
    } do |res, params|
      res.restaurant_id
    end
  end
