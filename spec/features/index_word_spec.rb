require "rails_helper"

feature "単語の一覧" do
  given(:user) { create :user, words: words }
  given(:words) { create_list :word, 3 }
  scenario "登録された単語を一覧で表示する" do
    log_in_as user
    click_link I18n.t("title.word_index")
    words.each { |word| expect(page).to have_content word.content }
  end
end
