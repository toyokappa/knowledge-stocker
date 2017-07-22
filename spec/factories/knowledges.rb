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

FactoryGirl.define do
  factory :knowledge do
    url { Faker::Internet.url }
    understanding { Faker::Number.between(0,5) }
    word
  end
end
