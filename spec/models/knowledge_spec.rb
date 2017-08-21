# == Schema Information
#
# Table name: knowledges
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  word_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  understanding :integer          default(0)
#
# Indexes
#
#  index_knowledges_on_understanding  (understanding)
#  index_knowledges_on_word_id        (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (word_id => words.id)
#

require "rails_helper"

RSpec.describe Knowledge, type: :model do
  it "has a valid factory" do
    expect(build(:knowledge)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:word) }
  end

  describe "scope" do
    describe ".understanding_order" do
      let!(:understanding_1) { create(:knowledge, understanding: 1) }
      let!(:understanding_2) { create(:knowledge, understanding: 2) }
      let!(:understanding_3) { create(:knowledge, understanding: 3) }
      let!(:knowledge_order) { [understanding_3, understanding_2, understanding_1] }

      subject(:relation) { described_class.understanding_order }

      it "returns sort order by understanding desc" do
        expect(relation.ids).to eq knowledge_order.map(&:id)
      end
    end
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to ensure_valid_url_format_of(:url) }
  end
end
