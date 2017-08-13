require "rails_helper"

feature "プロフィール編集" do
  before do
    log_in_as user
    click_link I18n.t("title.profile")
    click_link I18n.t("link.edit")
    fill_in User.human_attribute_name(:name), with: update_user.name
    fill_in User.human_attribute_name(:email), with: update_user.email
    fill_in User.human_attribute_name(:password), with: update_user.password
    fill_in User.human_attribute_name(:password_confirmation), with: update_user.password_confirmation
    click_button I18n.t("helpers.submit.update")
  end

  context "正しい値が入力された場合" do
    given(:user) { create :user }
    given(:update_user) { build :user }
    scenario "プロフィール編集に成功する" do
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end

  context "不正な値が入力された場合" do
    given(:user) { create :user }
    given(:update_user) { build :user, name: " ", email: "invalid@example", password: "foo", password_confirmation: "bar" }
    scenario "プロフィール編集に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 4)
    end
  end
end
