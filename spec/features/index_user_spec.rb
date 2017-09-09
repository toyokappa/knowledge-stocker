require "rails_helper"

feature "ユーザー一覧" do
  given(:user) { create :user }
  context "ユーザーが10人以下の場合" do
    before { @users = create_list(:user, 9) }
    scenario "全てのユーザーを1ページに表示する" do
      login_as user
      visit users_path
      expect(page).to have_content user.name
      @users.each { |other_user| expect(page).to have_content other_user.name }
      expect(page).not_to have_link(2, href: "/users?page=2")
    end
  end

  context "ユーザーが10人より多い場合" do
    before { create_list(:user, 10) }
    scenario "ページネーションで2ページに分割する" do
      login_as user
      visit users_path
      expect(page).to have_link(2, href: "/users?page=2")
    end
  end
end
