require "rails_helper"

feature "Word registration" do
  given(:user) { create(:user) }

  context "with invalid attributes" do
    given(:invalid_word) { build(:invalid_word) }

    scenario "user cannot register word" do
      log_in_as(user)
      click_link I18n.t("link.register_word")
      expect{
        fill_in I18n.t("activerecord.attributes.word.content"), with: invalid_word.content
        click_button I18n.t("helpers.submit.create")
      }.not_to change(Word, :count)
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end

  context "with valid attributes" do
    given(:valid_word) { build(:word) }

    scenario "user can register word" do
      log_in_as(user)
      click_link I18n.t("link.register_word")
      expect{
        fill_in I18n.t("activerecord.attributes.word.content"), with: valid_word.content
        click_button I18n.t("helpers.submit.create")
      }.to change(Word, :count).by(1)
      expect(page).to have_content I18n.t("flash.registration_success")
    end
  end
end

feature "Word edit" do
  given(:word) { create(:word) }

  context "with invalid attributes" do
    given(:invalid_word) { build(:invalid_word) }
    given(:invalid_knowledge) { build(:invalid_knowledge) }

    scenario "user cannot edit word" do
      log_in_as(word.user)
      visit edit_word_path(word)
      expect{
        fill_in I18n.t("activerecord.attributes.word.content"), with: invalid_word.content
        fill_in I18n.t("activerecord.attributes.knowledge.url"), with: invalid_knowledge.url
        click_button I18n.t("helpers.submit.update")
      }.not_to change(Knowledge, :count)
      expect(page).to have_content I18n.t("flash.errors_count", count: 2)
    end
  end

  context "width valid attributes" do
    given(:valid_word) { build(:word) }
    given(:valid_knowledge) { build(:knowledge) }

    scenario "user can edit word" do
      log_in_as(word.user)
      visit edit_word_path(word)
      expect{
        fill_in I18n.t("activerecord.attributes.word.content"), with: valid_word.content
        fill_in I18n.t("activerecord.attributes.knowledge.url"), with: valid_knowledge.url
        fill_in I18n.t("activerecord.attributes.knowledge.understanding"), with: valid_knowledge.understanding
        click_button I18n.t("helpers.submit.update")
      }.to change(Knowledge, :count).by(1)
      expect(page).to have_content I18n.t("flash.update_success")
    end
  end
end

feature "Word delete" do
  given(:knowledge) { create(:knowledge) }

  scenario "user can delete" do
    log_in_as(knowledge.word.user)
    visit word_path(knowledge.word)
    expect{
      click_link I18n.t("link.delete")
    }.to change(Word, :count).by(-1).and change(Knowledge, :count).by(-1)
  end

  scenario "user can url delete through word edit" do
    log_in_as(knowledge.word.user)
    visit edit_word_path(knowledge.word)
    expect{
      check "word_knowledges_attributes_0__destroy"
      click_button I18n.t("helpers.submit.update")
    }.to change(Knowledge, :count).by(-1)
  end
end
