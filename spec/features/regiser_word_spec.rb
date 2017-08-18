require "rails_helper"

feature "単語登録" do
  before do
    user = create(:user)

    login_as user
    visit new_word_path
    fill_in "word_content", with: content
    click_button I18n.t("helpers.submit.create")
  end

  context "正しい値が入力された場合" do
    given(:content) { "valid" }

    scenario "単語登録に成功する" do
      expect(page).to have_content I18n.t("flash.registration_success")
      expect(page).to have_content content
    end
  end

  context "不正な値が入力された場合" do
    given(:content) { " " }
    
    scenario "単語登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
