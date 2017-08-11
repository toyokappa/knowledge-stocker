require "rails_helper"

feature "Authentication" do
  given(:user) { create(:user) }
  given(:invalid_user) { build(:invalid_user) }

  scenario "login failed" do
    log_in_as(invalid_user)
    expect(page).to have_content I18n.t("flash.authentication_failed")
  end

  scenario "login success" do
    log_in_as(user)
    expect(page).to have_link I18n.t("link.logout")
  end

  scenario "logout success" do
    log_in_as(user)
    click_link I18n.t("link.logout")
    expect(page).to have_link I18n.t("link.login")
  end
end
