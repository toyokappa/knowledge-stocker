require "rails_helper"

feature "URLの削除" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }
  given!(:knowledge) { create :knowledge, word: word }

  scenario "削除できる" do
    login_as user
    visit edit_word_path(word)
    check "word_knowledges_attributes_0__destroy"
    click_button I18n.t("helpers.submit.update")
    expect(page).not_to have_content knowledge.url
    click_link I18n.t("title.word_index")
    expect(page).not_to have_content I18n.t("view.understood_site")
  end
end
