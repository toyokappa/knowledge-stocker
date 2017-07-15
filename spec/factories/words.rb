FactoryGirl.define do
  factory :word do
    content { Faker::Lorem.word }
    user
  end
end
