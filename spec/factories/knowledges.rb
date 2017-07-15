FactoryGirl.define do
  factory :knowledge do
    url { Faker::Internet.url }
    understanding { Faker::Number.between(0,5) }
    word
  end
end
