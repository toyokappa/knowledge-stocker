require "rails_helper"

feature "URLの削除" do
  given(:knowledge) { create :knowledge }
  scenario "URLの削除に成功する" do
    login_as knowledge.word.user
    click_link I18n.t("title.word_index")
    click_link I18n.t("link.edit")
    check "word_knowledges_attributes_0__destroy"
    click_button I18n.t("helpers.submit.update")
    expect(page).not_to have_content knowledge.url
    click_link I18n.t("title.word_index")
    expect(page).not_to have_content I18n.t("view.understood_site")
  end
end
