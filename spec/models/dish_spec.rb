require 'rails_helper'

RSpec.describe Dish, type: :model do
  it "has valid factory" do
    expect(build :dish).to be_valid
  end

  describe "ActiveModel validations" do
    subject { build :dish }
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe "ActiveRecord associations" do
    subject { build :dish }
    it { should belong_to(:restaurant) }
  end

end
