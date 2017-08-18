require "rails_helper"

feature "URLの登録" do
  before do
    log_in_as word.user
    click_link I18n.t("title.word_index")
    click_link I18n.t("link.edit")
    fill_in Knowledge.human_attribute_name(:url), with: url
    fill_in Knowledge.human_attribute_name(:understanding), with: understanding
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値を入力した場合" do
    given(:word) { create :word }
    given(:url) { "http://valid.com" }
    given(:understanding) { 5 }

    scenario "URLの登録に成功する" do
      expect(page).to have_content url
      click_link I18n.t("title.word_index")
      expect(page).to have_content I18n.t("view.understood_site")
    end
  end

  context "不正な値を入力した場合" do
    given(:word) { create :word }
    given(:url) { "invalid" }
    given(:understanding) { 1 }

    scenario "URLの登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
