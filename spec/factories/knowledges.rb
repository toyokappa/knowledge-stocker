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

FactoryGirl.define do
  factory :knowledge do
    url { Faker::Internet.url }
    understanding { Faker::Number.between(0,5) }
    word
  end

  factory :invalid_knowledge, class: Knowledge do
    url "aaa"
  end
end
