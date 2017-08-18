require "rails_helper"

feature "ユーザー登録" do
  before do
    visit login_path
    click_link I18n.t("title.user_registration")
    fill_in "user_name", with: user.name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password_confirmation
    click_button I18n.t("helpers.submit.create")
  end

  context "正しい値が入力された場合" do
    given(:user) { build :user }
    scenario "ユーザー登録に成功する" do
      expect(page).to have_content I18n.t("flash.registration_success")
    end
  end

  context "不正なユーザー名が入力された場合" do
    given(:user) { build :user, name: " " }
    scenario "ユーザー登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なEmailが入力された場合" do
    given(:user) { build :user, email: "invalid@example" }
    scenario "ユーザー登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なパスワードが入力された場合" do
    given(:user) { build :user, password: "foo", password_confirmation: "foo" }
    scenario "ユーザー登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "パスワードとパスワード（確認用）が一致しない場合" do
    given(:user) { build :user, password: "foobar", password_confirmation: "foobaz" }
    scenario "ユーザー登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
