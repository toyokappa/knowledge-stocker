require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  it "has a valid factory" do
    expect(build(:knowledge)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:word) }
  end

  describe "default_scope" do
    subject { knowledge_first }
    context "when different understanding" do
      before do
        create(:knowledge, :level_1)
        create(:knowledge, :level_3)
      end
      let(:knowledge_first) { create(:knowledge, :level_5) }

      it { is_expected.to eq Knowledge.first }
    end
    context "when same understanding" do
      before do
        create(:knowledge, :updated_in_1_hour)
        create(:knowledge, :updated_in_10_minutes)
      end
      let(:knowledge_first) { create(:knowledge, :updated_most_recent)}

      it { is_expected.to eq Knowledge.first }
    end
  end

  describe "validation" do
    it { is_expected.to ensure_valid_url_format_of(:url) }
  end
end
