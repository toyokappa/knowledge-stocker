# == Schema Information
#
# Table name: words
#
#  id         :integer          not null, primary key
#  content    :string(255)      not null
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
      before do
        id1 = create(:word, id: 1)
        id2 = create(:word, id: 2)
        id3 = create(:word, id: 3)
        @word_order = [id3, id2, id1]
      end
      subject(:relation) { described_class.id_order }

      it "returns sort order by understanding desc" do
        expect(relation.ids).to eq @word_order.map(&:id)
      end
    end

    describe ".with_knowledges" do
      before do
        words = create_list(:word, 5)
        create(:knowledge, word: words.first)
        create(:knowledge, word: words.second)
        create(:knowledge, word: words.last)
        @word_list = [words.first, words.second, words.last]
      end
      subject(:knowledges) { described_class.with_knowledges }

      it "returns words with knowledges" do
        expect(knowledges.ids).to match_array @word_list.map(&:id)
      end
    end

    describe ".without_knowledges" do
      before do
        @words = create_list(:word, 3)
        words_with_knowledge = create_list(:word, 2)
        words_with_knowledge.each { |word| create(:knowledge, word: word) }
      end
      subject(:words_without_knowledges) { described_class.without_knowledges }

      it "returns words without knowledges" do
        expect(words_without_knowledges.ids).to match_array @words.map(&:id)
      end
    end
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(50) }
  end
end
