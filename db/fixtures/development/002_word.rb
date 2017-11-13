word_index = 1
User.all.each do |user|
  20.times do
    Word.seed_once do |s|
      s.id = word_index
      s.content = Faker::Book.title
      s.user = user
    end
    word_index += 1
  end
end
