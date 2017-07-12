require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Test User", email: "test@user.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  it "is valid" do
    expect(@user.valid?).to eq true
  end

  describe "#name" do
    it "is present" do
      @user.name = "  "
      expect(@user.valid?).to eq false
    end

    it "has 30 characters or less" do
      @user.name = "a" * 31
      expect(@user.valid?).to eq false
    end
  end
end
