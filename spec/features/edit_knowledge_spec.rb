require "rails_helper"

feature "URLの編集" do
  before do
    user = create(:user)
    word = create(:word, user: user)
    create(:knowledge, word: word)

    login_as user
    visit edit_word_path(word)
    fill_in "word_knowledges_attributes_0_url", with: url
    fill_in "word_knowledges_attributes_0_understanding", with: understanding
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値を入力した場合" do
    given(:url) { "http://valid.com" }
    given(:understanding) { 5 }

    scenario "URLの編集に成功する" do
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end

  context "不正な値を入力した場合" do
    given(:url) { "invalid" }
    given(:understanding) { 1 }

    scenario "URLの編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
