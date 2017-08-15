require "rails_helper"

feature "単語の一覧" do
  given(:user) { create :user, words: [word1, word2, word3] }
  given(:word1) { create :word }
  given(:word2) { create :word }
  given(:word3) { create :word }
  scenario "登録された単語を一覧で表示する" do
    log_in_as user
    click_link I18n.t("title.word_index")
    expect(page).to have_content word1.content
    expect(page).to have_content word2.content
    expect(page).to have_content word3.content
  end
end
