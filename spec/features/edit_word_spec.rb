require "rails_helper"

feature "単語の編集" do
  before do
    log_in_as word.user
    click_link I18n.t("title.word_index")
    click_link I18n.t("link.edit")
    fill_in Word.human_attribute_name(:content), with: content
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:word) { create :word }
    given(:content) { "valid content" }
    scenario "単語編集に成功する" do
      expect(page).to have_content I18n.t("flash.update_success")
      expect(page).to have_content content
    end
  end

  context "不正な値が入力された場合" do
    given(:word) { create :word }
    given(:content) { " " }
    scenario "単語編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
