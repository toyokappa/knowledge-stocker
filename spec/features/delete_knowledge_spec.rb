require "rails_helper"

feature "URLの削除" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }
  before { @knowledge = create(:knowledge, word: word) }

  scenario "削除できる" do
    login_as user
    visit word_path(word)
    click_link "URLを削除"
    expect(page).to have_content I18n.t("flash.delete_success")
    expect(current_path).to eq word_path(word)
    visit knowledges_path
    expect(page).not_to have_content word.content
    visit words_path
    expect(page).to have_content word.content
  end
end
