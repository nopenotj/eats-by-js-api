require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET #show" do
      let(:user) { create :user }
      it "should return with OK response if exists" do
        get user_path(user.id)
        expect(response).to have_http_status(:ok)
      end
      it "should return with 404 NOT_FOUND response if does not exist" do
        # server must respond with 404 not found when processing request to fetch single resource that doesnt exists
        # unless 200 OK with null as primary data
        user
        get user_path(User.last.id + 1)
        expect(response).to have_http_status(:not_found)
      end
    end
end
