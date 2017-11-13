index = 1
20.times do |i|
  words = User.find(i+1).words.limit(15)
  words.each do |word|
    Knowledge.seed_once do |s|
      s.id = index
      s.url = Faker::Internet.url
      s.understanding = Faker::Number.between(1, 5)
      s.word = word
    end
    index += 1
  end
end
