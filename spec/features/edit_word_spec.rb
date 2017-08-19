require "rails_helper"

feature "単語の編集" do
  before do
    user = create(:user)
    word = create(:word, user: user)

    login_as user
    visit edit_word_path(word)
    fill_in "word_content", with: content
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:content) { Faker::Lorem.word }
    scenario "更新できる" do
      expect(page).to have_content I18n.t("flash.update_success")
      expect(page).to have_content content
    end
  end

  context "不正な値が入力された場合" do
    given(:content) { nil }
    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
