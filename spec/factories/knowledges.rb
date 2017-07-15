FactoryGirl.define do
  factory :knowledge do
    url { Faker::Internet.url }
    understanding { Faker::Number.between(0,5) }
    word

    trait :level_5 do
      understanding { 5 }
    end

    trait :level_3 do
      understanding { 3 }
    end

    trait :level_1 do
      understanding { 1 }
    end

    trait :updated_most_recent do
      understanding { 5 }
      updated_at { Time.now }
    end

    trait :updated_in_10_minutes do
      understanding { 5 }
      updated_at { 10.minutes.ago }
    end

    trait :updated_in_1_hour do
      understanding { 5 }
      updated_at { 1.hour.ago }
    end
  end
end
