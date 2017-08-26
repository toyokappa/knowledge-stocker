require "rails_helper"

feature "単語の一覧" do
  given(:user) { create :user }
  before { @words = create_list(:word, 3, user: user) }
  scenario "登録された単語を一覧で表示する" do
    login_as user
    visit words_path
    @words.each { |word| expect(page).to have_content word.content }
  end
end
