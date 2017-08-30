require "rails_helper"

feature "URLの削除" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }
  before { @knowledge = create(:knowledge, word: word) }

  scenario "削除できる" do
    login_as user
    visit edit_word_path(word)
    check "word[knowledges_attributes][0][_destroy]"
    click_button I18n.t("helpers.submit.update")
    visit knowledges_path
    expect(page).not_to have_content word.content
    visit words_path
    expect(page).to have_content word.content
  end
end
