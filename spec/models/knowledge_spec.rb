require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  it "has a valid factory" do
    expect(build(:knowledge)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:word) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:url)}
    it { is_expected.to ensure_valid_url_format_of(:url) }
  end
end
