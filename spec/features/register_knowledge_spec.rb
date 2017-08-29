require "rails_helper"

feature "URLの登録" do
  given(:user) { create :user }
  given(:word) { create :word, user: user }
  before do
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
      expect(current_path).to eq word_path(word)
      expect(page).to have_content url
      visit words_path
      expect(page).not_to have_content word.content
      visit knowledges_path
      expect(page).to have_content word.content
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
