# == Schema Information
#
# Table name: words
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_words_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require "rails_helper"

RSpec.describe Word, type: :model do
  it "has a valid factory" do
    expect(build(:word)).to be_valid
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:knowledges).dependent(:destroy) }
  end

  describe "scope" do
    describe ".id_order" do
      let!(:id_1) { create(:word, id: 1) }
      let!(:id_2) { create(:word, id: 2) }
      let!(:id_3) { create(:word, id: 3) }
      let!(:word_order) { [id_3, id_2, id_1] }

      subject(:relation) { described_class.id_order }

      it "returns sort order by understanding desc" do
        expect(relation.ids).to eq word_order.map(&:id)
      end
    end
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(50) }
  end
end
