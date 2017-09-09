require "rails_helper"

feature "単語の削除" do
  given(:user) { create :user }
  before do
    @word = create(:word, user: user)
    login_as user
  end

  feature "トップページ" do
    scenario "削除できる" do
      click_link "word_delete"
      expect(page).to have_content I18n.t("flash.delete_success")
      expect(current_path).to eq root_path
      expect(page).not_to have_content @word.content
    end
  end

  feature "単語一覧ページ" do
    scenario "削除できる" do
      visit words_path
      click_link "word_delete"
      expect(page).to have_content I18n.t("flash.delete_success")
      expect(current_path).to eq root_path
      expect(page).not_to have_content @word.content
    end
  end

  feature "知識一覧ページ" do
    before { create(:knowledge, word: @word) }

    scenario "削除できる" do
      visit knowledges_path
      click_link "word_delete"
      expect(page).to have_content I18n.t("flash.delete_success")
      expect(current_path).to eq root_path
      expect(page).not_to have_content @word.content
    end
  end

  feature "単語詳細ページ" do
    scenario "削除できる" do
      visit word_path(@word)
      click_link "word_delete"
      expect(page).to have_content I18n.t("flash.delete_success")
      expect(current_path).to eq root_path
      expect(page).not_to have_content @word.content
    end
  end
end
