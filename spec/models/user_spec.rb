require 'rails_helper'

RSpec.describe User, type: :model do
  it "DB Validation: cannot have null user" do
    expect {FactoryBot.create :user , username: nil}.to raise_error
  end
  it "cannot have null password" do
    expect { FactoryBot.create :user , password: nil }.to raise_error
  end
end
