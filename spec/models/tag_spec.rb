require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "has a valid factory" do
    expect(build(:tag)).to be_valid
  end

  let(:tag) { build(:tag) }

  describe "ActiveModel validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "ActiveRecord associations" do
    xit { should have_and_belongs_to_many(:restaurants) }
  end

end
