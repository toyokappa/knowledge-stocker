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
    given(:url) { Faker::Internet.url }
    given(:understanding) { 5 }
    scenario "更新できる" do
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end

  context "不正な値を入力した場合" do
    given(:url) { "foobar" }
    given(:understanding) { 1 }
    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
