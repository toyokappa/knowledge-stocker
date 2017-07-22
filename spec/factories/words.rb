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

FactoryGirl.define do
  factory :word do
    content { Faker::Lorem.word }
    user
  end
end
