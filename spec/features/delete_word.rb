require "rails_helper"

feature "単語の削除" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }

  scenario "単語の削除に成功する" do
    login_as user
    visit edit_word_path(word)
    expect(page).to have_content I18n.t("flash.delete_success")
  end
end
