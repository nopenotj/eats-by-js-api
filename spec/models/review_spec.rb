require 'rails_helper'

RSpec.describe Review, type: :model do
  it "has a valid factory" do
    expect(build(:review)).to be_valid
  end

  let(:review) { build(:review) }

  describe "ActiveModel validations" do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:rating) }
  end

  describe "ActiveRecord associations" do
    it { should belong_to(:user) }
    it { should belong_to(:restaurant) }
  end

end
