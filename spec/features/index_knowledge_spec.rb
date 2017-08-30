require "rails_helper"

feature "知識リストページ" do
  feature "表示確認" do
    given(:user) { create(:user) }
    before do
      words = create_list(:word, 3, user: user)
      create(:knowledge, word: words.first)
      create(:knowledge, word: words.last)
      @knowledges = [words.first, words.last]
    end

    scenario "知識を持つ単語のみ表示する" do
      login_as user
      visit knowledges_path
      @knowledges.each { |knowledge| expect(page).to have_content knowledge.content }
    end
  end

  feature "ページネーション" do
    given(:user) { create :user }
    context "知識を持つ単語が10個以下の場合" do
      before do
        words = create_list(:word, 10, user: user)
        words.each { |word| create(:knowledge, word: word) }
      end

      scenario "ページネーションを非表示にする" do
        login_as user
        visit knowledges_path
        expect(page).not_to have_link(2, href: "/knowledges?page=2")
      end
    end

    context "知識を持つ単語が10個より多い場合" do
      before do
        words = create_list(:word, 11, user: user)
        words.each { |word| create(:knowledge, word: word) }
      end

      scenario "ページネーションを表示する" do
        login_as user
        visit knowledges_path
        expect(page).to have_link(2, href: "/knowledges?page=2")
      end
    end
  end
end
