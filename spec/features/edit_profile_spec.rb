require "rails_helper"

feature "プロフィール編集" do
  before do
    user = create(:user)

    login_as user
    visit edit_user_path(user)
    fill_in User.human_attribute_name(:name), with: name
    fill_in User.human_attribute_name(:email), with: email
    fill_in User.human_attribute_name(:password), with: password
    fill_in User.human_attribute_name(:password_confirmation), with: password_confirmation
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:name) { "Valid Name"}
    given(:email) { "valid@email.com" }
    given(:password) { "valid password" }
    given(:password_confirmation) { "valid password" }

    scenario "プロフィール編集に成功する" do
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end

  context "不正な値が入力された場合" do
    given(:name) { " " }
    given(:email) { "invalid@email" }
    given(:password) { "foo" }
    given(:password_confirmation) { "bar" }

    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 4)
    end
  end
end
