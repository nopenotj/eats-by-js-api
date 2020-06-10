require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "has valid factory" do
    expect(build :restaurant).to be_valid
  end

  subject { build :restaurant }

  describe "ActiveModel validations" do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:dishes).dependent(:destroy) }
    xit { should have_and_belongs_to_many(:tags) }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      it { should respond_to(:rating)}
    end
    context "executes methods correctly" do
      it "should calc average rating of all users when rating is called" do
        restaurant = create :restaurant
        reviews = create_list(:review, 3, restaurant: restaurant)
        expect(restaurant.rating).to eq(restaurant.reviews.map(&:rating).sum / reviews.length.to_f)
      end
    end
  end
  describe "public class methods" do
    subject { Restaurant }
    context "responds to its methods" do
      it { should respond_to(:search)}
    end

    context "executes methods correctly" do
      context "self.search" do
        it "should give valid results" do
          create_list(:restaurant, 3)
          search_term = "a"
          subject.search(search_term).map(&:title).each { |n|
            expect(n).to include(search_term)
          }
        end
      end
    end
  end
end
