require "rails_helper"

feature "単語一覧" do
  feature "トップページ" do
    given(:user) { create :user }
    context "登録済みの単語が10個以下の場合" do
      before { @words = create_list(:word, 10, user: user) }
      scenario "全ての単語を1ページに表示する" do
        login_as user
        visit root_path
        @words.each { |word| expect(page).to have_content word.content }
        expect(page).not_to have_content I18n.t("link.more_words")
      end
    end
    context "登録済みの単語が10個より多い場合" do
      before { @words = create_list(:word, 11, user: user) }
      scenario "単語一覧ページへのリンクを表示する" do
        login_as user
        visit root_path
        expect(page).to have_content I18n.t("link.more_words")
      end
    end
  end

  feature "単語一覧ページ" do
    given(:user) { create :user }
    context "登録済みの単語が10個以下の場合" do
      before { @words = create_list(:word, 10, user: user) }
      scenario "全ての単語を1ページに表示する" do
        login_as user
        visit words_path
        @words.each { |word| expect(page).to have_content word.content }
        expect(page).not_to have_link(2, href: "/words?page=2")
      end
    end
    context "登録済みの単語が10個より多い場合" do
      before { @words = create_list(:word, 11, user: user) }
      scenario "ページネーションで2ページに分割する" do
        login_as user
        visit words_path
        expect(page).to have_link(2, href: "/words?page=2")
      end
    end
  end
end
