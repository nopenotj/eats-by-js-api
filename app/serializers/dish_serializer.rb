class DishSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :price
  end
