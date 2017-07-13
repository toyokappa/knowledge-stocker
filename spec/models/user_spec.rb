require 'rails_helper'
require 'validates_email_format_of/rspec_matcher'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  it { is_expected.to be_valid }

  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(30) }
  end

  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_email_format_of(:email).
                        with_message('は不正な形式です') }
  end

  describe "#password" do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "#association" do
    it { is_expected.to have_many(:words).dependent(:destroy) }
  end
end
