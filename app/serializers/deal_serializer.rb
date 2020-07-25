class DealSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :start_time, :end_time
  end
