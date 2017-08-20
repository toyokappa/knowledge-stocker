require "rails_helper"

feature "URLの登録" do
  before do
    user = create(:user)
    word = create(:word, user: user)

    login_as user
    visit edit_word_path(word)
    fill_in "word[knowledges_attributes][0][url]", with: url
    fill_in "word[knowledges_attributes][0][understanding]", with: understanding
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値を入力した場合" do
    given(:url) { Faker::Internet.url }
    given(:understanding) { 5 }
    scenario "登録できる" do
      expect(page).to have_content url
      click_link I18n.t("title.word_index")
      expect(page).to have_content I18n.t("view.understood_site")
    end
  end

  context "不正な値を入力した場合" do
    given(:url) { "foobar" }
    given(:understanding) { 1 }
    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
