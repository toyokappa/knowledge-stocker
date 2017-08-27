require "rails_helper"

feature "知識リスト" do
  given(:user) { create(:user) }
  before do
    words = create_list(:word, 3, user: user)
    create(:knowledge, word: words.first)
    create(:knowledge, word: words.last)
    @knowledges = [words.first, words.last]
  end

  scenario "知識の一覧を表示" do
    login_as user
    visit knowledges_path
    @knowledges.each { |knowledge| expect(page).to have_content knowledge.content }
  end
end
