require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "#destroy" do
    before(:each) {
      @restaurant = FactoryBot.create :restaurant
      @dish = FactoryBot.create :dish ,restaurant: @restaurant
      user = FactoryBot.create :user
      @review = FactoryBot.create :review ,restaurant: @restaurant, user: user
    }
    it "should remove restaurant" do
      expect{@restaurant.destroy}.to change{Restaurant.count}.by(-1)
    end
    it "should remove dish" do
      expect{@restaurant.destroy}.to change{Dish.count}.by(-1)
    end
    it "should remove reviews" do
      expect{@restaurant.destroy}.to change{Review.count}.by(-1)
    end
    it "should not delete user" do
      expect{@restaurant.destroy}.to_not change{User.count}
    end
  end

end
