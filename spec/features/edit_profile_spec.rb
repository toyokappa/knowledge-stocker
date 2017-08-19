require "rails_helper"

feature "プロフィール編集" do
  given(:user) { create :user }
  before do
    login_as user
    visit edit_user_path(user)
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:name) { Faker::Name.name }
    given(:email) { Faker::Internet.unique.email }
    given(:password) { "password" }
    given(:password_confirmation) { "password" }

    scenario "更新できる" do
      expect(page).to have_content I18n.t("flash.update_success")
      expect(page).to have_content name
      expect(page).to have_content email
    end
  end

  context "不正なユーザー名が入力された場合" do
    given(:name) { nil }
    given(:email) { user.email }
    given(:password) { user.password }
    given(:password_confirmation) { user.password_confirmation }

    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なEmailが入力された場合" do
    given(:name) { user.name }
    given(:email) { "invalid@email" }
    given(:password) { user.password }
    given(:password_confirmation) { user.password_confirmation }

    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なパスワードが入力された場合" do
    given(:name) { user.name }
    given(:email) { user.email }
    given(:password) { "foo" }
    given(:password_confirmation) { "foo" }

    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "パスワードとパスワード（確認用）が一致しない場合" do
    given(:name) { user.name }
    given(:email) { user.email }
    given(:password) { "foobar" }
    given(:password_confirmation) { "foobaz" }

    scenario "更新できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
