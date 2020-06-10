require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let (:sample_restaurant_json_params) { 
    {
      data: {
        type: "restaurants",
        attributes: attributes_for(:restaurant)
      }
    }
  }
  
  it { should permit(:type, :attribute, :relationships)
    .for(:create, params: :sample_restaurant_json_params)
    .on(:user)
  }


  describe "#index" do
    context "when GET request is made to /restaurants" do
      it "should return with OK response" do
        get restaurants_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#show" do
    # need test for HTTP STATUS 200 OK
    context "when GET request is made to /restaurants/:id" do
      let(:restaurant) { create :restaurant }
      it "should return with OK response if exists" do
        get restaurants_path(restaurant.id)
        expect(response).to have_http_status(:ok)
      end
      it "should return with 404 NOT_FOUND response if does not exist" do
        # server must respond with 404 not found when processing request to fetch single resource that doesnt exists
        # unless 200 OK with null as primary data
        restaurant
        get restaurant_path(Restaurant.last.id + 1)
        expect(response).to have_http_status(:not_found)
      end
      pending "should contain valid JSON content"

    end
  end

  describe "#create" do
    context "when POST create request is made to controller" do
      let(:user) { create :user }
      let(:token) { JsonWebToken.encode(user_id: user.id) }
      let(:attrs) { attributes_for(:restaurant) }
      let(:json_request) { 
        {
          data: {
            attributes: attrs
          }
        }
      }

      it "should not allow unauthenticated requests" do
        post restaurants_path
        expect(response.body).to match("Not Authorized")
        expect(response).to have_http_status(:unauthorized)
      end

      it "should allow authenticated requests" do
        post restaurants_path, params: json_request, headers: {'Authorization' => "Bearer #{token}"}
        expect(response).to_not have_http_status(:unauthorized)
        expect(response.body).to_not match("Not Authorized")
      end

      context "when request is authenticated" do
        it "should create the object" do
          post restaurants_path, params: json_request, headers: {'Authorization' => "Bearer #{token}"}

          expect(Restaurant.find_by(title: attrs[:title])).not_to be_nil
        end
        it "should return 201 CREATED if sucessful" do
          post restaurants_path, params: json_request, headers: {'Authorization' => "Bearer #{token}"}
          expect(response).to have_http_status(:created)
        end
        it "should contain location if sucessful" do
          post restaurants_path, params: json_request, headers: {'Authorization' => "Bearer #{token}"}
          expect(response.location).to_not be_nil
        end
      end

    end
  end
  describe "#update" do
    context "when POST update request is made to controller" do
      let(:restaurant) { create :restaurant }
      let(:user) { create :user }
      let(:token) { JsonWebToken.encode(user_id: user.id) }
      let(:updated_params) {
        {
          data: { 
            attributes: {
              title: Faker::Restaurant.name,
              description: Faker::Restaurant.description
            }
          }
        }
      }

      it "should not allow unauthenticated requests" do
        put restaurant_path(restaurant.id)
        expect(response.body).to match("Not Authorized")
      end

      context "when request is authenticated" do
        subject { put restaurant_path(restaurant.id), params: updated_params, headers: {'Authorization' => "Bearer #{token}"} }
        it "should return 200 OK status" do
          subject
          expect(response).to have_http_status(:ok)
        end
        it "should update the object" do
          subject
          restaurant.reload

          expect(restaurant.title).to eq(updated_params[:data][:attributes][:title])
          expect(restaurant.description).to eq(updated_params[:data][:attributes][:description])
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

      it "should return 200 OK if authenticated" do
        delete restaurant_path(restaurant.id), params: nil, headers: {'Authorization' => "Bearer #{token}"}
        expect(response).to have_http_status(:ok)
      end

    end
  end
end
