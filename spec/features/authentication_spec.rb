require "rails_helper"

feature "認証" do
  feature "ログイン" do
    before do
      visit login_path
      fill_in "session_email", with: email
      fill_in "session_password", with: password
      click_button I18n.t("link.login")
    end

    context "登録済みユーザーの情報を入力した場合" do
      given(:user) { create :user }
      given(:email) { user.email }
      given(:password) { user.password }

      scenario "ログインできる" do
        expect(current_path).to eq root_path
        expect(page).to have_link I18n.t("link.logout")
        visit user_path
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end

    context "Emailとパスワードが未入力の場合" do
      given(:email) { nil }
      given(:password) { nil }

      scenario "ログインできない" do
        expect(page).to have_content I18n.t("flash.authentication_failed")
      end
    end

    context "登録済みユーザーのEmailと不正なパスワードを入力した場合" do
      given(:user) { create :user }
      given(:email) { user.email }
      given(:password) { "invalid" }

      scenario "ログインできない" do
        expect(page).to have_content I18n.t("flash.authentication_failed")
      end
    end

    context "未登録ユーザーのEmailとパスワードを入力した場合" do
      given(:email) { "invalid@email.com" }
      given(:password) { "invalid" }

      scenario "ログインできない" do
        expect(page).to have_content I18n.t("flash.authentication_failed")
      end
    end
  end

  feature "ログアウト" do
    given(:user) { create :user }
    scenario "ログアウトできる" do
      login_as user
      click_link I18n.t("link.logout")
      expect(page).to have_link I18n.t("link.login")
    end
  end
end
