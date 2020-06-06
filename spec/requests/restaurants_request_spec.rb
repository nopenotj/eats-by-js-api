require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "#update" do
    context "when POST update request is made to controller" do
      let(:restaurant) { create :restaurant }
      let(:user) { create :user }
      let(:token) { JsonWebToken.encode(user_id: user.id) }
      let(:updated_params) {
        {
          restaurant: { 
            title: Faker::Restaurant.name,
            description: Faker::Restaurant.description
          }
        }
      }

      it "should not allow unauthenticated requests" do
         put restaurant_path(restaurant.id)
         expect(response.body).to match("Not Authorized")
      end

      it "should allow authenticated requests" do
         put restaurant_path(restaurant.id), params: updated_params, headers: {'Authorization' => "Bearer #{token}"}
         expect(response.body).to match("success")
      end

      context "when request is authenticated" do
        it "should update the object" do
          put restaurant_path(restaurant.id), params: updated_params, headers: {'Authorization' => "Bearer #{token}"}
          restaurant.reload

          expect(response.body).to match("success")
          expect(restaurant.title).to eq(updated_params[:restaurant][:title])
          expect(restaurant.description).to eq(updated_params[:restaurant][:description])
        end
      end
    end
  end

  describe "#destroy" do
    context "when destroying" do
      before(:each) {
        @restaurant = create :restaurant
        @dish = create :dish ,restaurant: @restaurant
        user = create :user
        @review = create :review ,restaurant: @restaurant, user: user
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

    context "when POST destroy request is made to controller" do
      let(:restaurant) { create :restaurant }
      let(:user) { create :user }
      let(:token) { JsonWebToken.encode(user_id: user.id) }

      it "should not allow unauthenticated requests" do
         delete restaurant_path(restaurant.id)
         expect(response.body).to match("Not Authorized")
      end

      it "should allow authenticated requests" do
         delete restaurant_path(restaurant.id), params: nil, headers: {'Authorization' => "Bearer #{token}"}
         expect(response.body).to match("success")
      end
      
    end
  end

end
