require "rails_helper"

feature "単語の削除" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }
  scenario "削除できる" do
    login_as user
    visit word_path(word)
    click_link I18n.t("link.delete")
    expect(page).to have_content I18n.t("flash.delete_success")
    expect(current_path).to eq words_path
    expect(page).not_to have_content word.content
  end
end
