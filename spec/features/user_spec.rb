require "rails_helper"

feature "User signup" do
  context "with invalid attributes" do
    given(:invalid_user) { build(:invalid_user) }

    scenario "user cannot signup" do
      visit login_path
      click_link I18n.t("title.user_registration")
      expect{
        fill_in I18n.t("activerecord.attributes.user.name"), with: invalid_user.name
        fill_in I18n.t("activerecord.attributes.user.email"), with: invalid_user.email
        fill_in I18n.t("activerecord.attributes.user.password"), with: invalid_user.password
        fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: invalid_user.password_confirmation
        click_button I18n.t("helpers.submit.create")
      }.not_to change(User, :count)
      expect(page).to have_content I18n.t("flash.errors_count", count: 4)
    end
  end

  context "with valid attributes" do
    given(:valid_user) { build(:user) }

    scenario "user can signup" do
      visit login_path
      click_link I18n.t("title.user_registration")
      expect{
        fill_in I18n.t("activerecord.attributes.user.name"), with: valid_user.name
        fill_in I18n.t("activerecord.attributes.user.email"), with: valid_user.email
        fill_in I18n.t("activerecord.attributes.user.password"), with: valid_user.password
        fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: valid_user.password
        click_button I18n.t("helpers.submit.create")
      }.to change(User, :count).by(1)
      expect(page).to have_content I18n.t("flash.registration_success")
      expect(page).to have_content I18n.t("title.profile")
    end
  end
end

feature "User edit" do
  given(:user) { create(:user) }

  context "with invalid attributes" do
    given(:invalid_user) { build(:invalid_user) }

    scenario "user cannot edit" do
      log_in_as(user)
      click_link I18n.t("title.profile")
      click_link I18n.t("link.edit")
      fill_in I18n.t("activerecord.attributes.user.name"), with: invalid_user.name
      fill_in I18n.t("activerecord.attributes.user.email"), with: invalid_user.email
      fill_in I18n.t("activerecord.attributes.user.password"), with: invalid_user.password
      fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: invalid_user.password_confirmation
      click_button I18n.t("helpers.submit.update")
      expect(page).to have_content I18n.t("flash.errors_count", count: 4)
    end
  end

  context "with valid attributes" do
    given(:valid_user) { build(:user) }

    scenario "user can edit" do
      log_in_as(user)
      click_link I18n.t("title.profile")
      click_link I18n.t("link.edit")
      fill_in I18n.t("activerecord.attributes.user.name"), with: valid_user.name
      fill_in I18n.t("activerecord.attributes.user.email"), with: valid_user.email
      fill_in I18n.t("activerecord.attributes.user.password"), with: valid_user.password
      fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: valid_user.password
      click_button I18n.t("helpers.submit.update")
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end
end
