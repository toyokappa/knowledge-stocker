require "rails_helper"

feature "プロフィール編集" do
  before do
    user = create(:user)

    login_as user
    visit edit_user_path(user)
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:name) { "Valid Name" }
    given(:email) { "valid@email.com" }
    given(:password) { "valid password" }
    given(:password_confirmation) { "valid password" }

    scenario "プロフィール編集に成功する" do
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end

  context "不正なユーザー名が入力された場合" do
    given(:name) { " " }
    given(:email) { "valid@email.com" }
    given(:password) { "valid password" }
    given(:password_confirmation) { "valid password" }

    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なEmailが入力された場合" do
    given(:name) { "Valid Name" }
    given(:email) { "invalid@email" }
    given(:password) { "valid password" }
    given(:password_confirmation) { "valid password" }

    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なパスワードが入力された場合" do
    given(:name) { "Valid Name" }
    given(:email) { "valid@email.com" }
    given(:password) { "foo" }
    given(:password_confirmation) { "foo" }

    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "パスワードとパスワード（確認用）が一致しない場合" do
    given(:name) { "Valid Name" }
    given(:email) { "valid@email.com" }
    given(:password) { "foobar" }
    given(:password_confirmation) { "foobaz" }

    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
