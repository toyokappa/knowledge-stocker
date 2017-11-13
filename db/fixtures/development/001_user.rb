User.seed_once do |s|
  s.id = 1
  s.name = "Yuta Toyokawa"
  s.email = "kppg42@gmail.com"
  s.password = "password"
  s.password_confirmation = "password"
end

50.times do |i|
  User.seed_once do |s|
    s.id = i + 2
    s.name = Faker::Name.name
    s.email = "user#{i + 1}@example.com"
    s.password = "password"
    s.password_confirmation = "password"
  end
end
