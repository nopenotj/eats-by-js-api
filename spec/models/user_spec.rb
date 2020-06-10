require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Database Validations" do
    it "cannot have null user" do
      expect {FactoryBot.create :user , username: nil}.to raise_error {"can't be blank"}
    end
    it "cannot have null password" do
      expect { FactoryBot.create :user , password: nil }.to raise_error {"can't be blank"}
    end
  end

  it "has valid factory" do
    expect(build :user).to be_valid
  end

  subject { build :user }

  describe "ActiveModel validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should have_secure_password }
    it { should validate_numericality_of(:role) }
    it { should validate_presence_of(:role) }
  end

  describe "ActiveRecord associations" do
    it { should have_many(:reviews) }
  end

  describe "public instance methods" do
    context "responds to its methods" do
      it { should respond_to(:isAdmin?)}
    end
    context "executes methods correctly" do
      pending "isAdmin? should correctly identify admin users"
    end
  end
end
