require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "is valid" do
    expect(user).to be_valid
  end

  describe "#name" do
    it "is present" do
      user.name = "  "
      expect(user).to be_invalid
    end

    it "has 30 characters or less" do
      user.name = "a" * 31
      expect(user).to be_invalid
    end
  end

  describe "#email" do
    it "is present" do
      user.email = "  "
      expect(user).to be_invalid
    end

    it "is unique" do
      duplication_user = user.dup
      duplication_user.email.upcase
      duplication_user.save
      expect(user).to be_invalid
    end

    it "has valid format" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it "has invalid format" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to be_invalid
      end
    end
  end

  describe "#password" do
    it "is present" do
      user.password = user.password_confirmation = " " * 6
      expect(user).to be_invalid
    end

    it "has 6 characters or more" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end
end
