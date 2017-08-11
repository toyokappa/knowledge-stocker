module Authentication
  def log_in_as(user)
    visit login_path
    fill_in I18n.t("activerecord.attributes.user.email"), with: user.email
    fill_in I18n.t("activerecord.attributes.user.password"), with: user.password
    click_button I18n.t("link.login")
  end
end
