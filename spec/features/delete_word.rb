require "rails_helper"

feature "単語の削除" do
  given(:word) { create :word }
  scenario "単語の削除に成功する" do
    login_as word.user
    click_link I18n.t("title.word_index")
    click_link I18n.t("link.delete")
    expect(page).to have_content I18n.t("flash.delete_success")
  end
end
