require "rails_helper"

feature "ユーザー登録" do
  given(:user) { build :user }
  before do
    visit login_path
    click_link I18n.t("title.user_registration")
    fill_in "user[name]", with: name
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password_confirmation
    click_button I18n.t("helpers.submit.create")
  end

  context "正しい値が入力された場合" do
    given(:name) { Faker::Name.name }
    given(:email) { Faker::Internet.unique.email }
    given(:password) { "password" }
    given(:password_confirmation) { "password" }

    scenario "登録できる" do
      expect(page).to have_content I18n.t("flash.registration_success")
    end
  end

  context "不正なユーザー名が入力された場合" do
    given(:name) { nil }
    given(:email) { user.email }
    given(:password) { user.password }
    given(:password_confirmation) { user.password_confirmation }

    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なEmailが入力された場合" do
    given(:name) { user.name }
    given(:email) { "invalid@email" }
    given(:password) { user.password }
    given(:password_confirmation) { user.password_confirmation }

    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "不正なパスワードが入力された場合" do
    given(:name) { user.name }
    given(:email) { user.email }
    given(:password) { "foo" }
    given(:password_confirmation) { "foo" }

    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "パスワードとパスワード（確認用）が一致しない場合" do
    given(:name) { user.name }
    given(:email) { user.email }
    given(:password) { "foobar" }
    given(:password_confirmation) { "foobaz" }

    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
