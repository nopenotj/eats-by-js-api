require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  describe "#index" do
    context "when GET request is made to /dishes" do
      it "should return with OK response" do
        get dishes_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#show" do
    # need test for HTTP STATUS 200 OK
    context "when GET request is made to /dishes/:id" do
      let(:dish) { create :dish }
      it "should return with OK response if exists" do
        get dishes_path(dish.id)
        expect(response).to have_http_status(:ok)
      end
      it "should return with 404 NOT_FOUND response if does not exist" do
        # server must respond with 404 not found when processing request to fetch single resource that doesnt exists
        # unless 200 OK with null as primary data
        dish
        get dish_path(Dish.last.id + 1)
        expect(response).to have_http_status(:not_found)
      end
      pending "should contain valid JSON content"

    end
  end
end
