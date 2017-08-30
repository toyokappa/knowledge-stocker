# == Schema Information
#
# Table name: words
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_words_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Word < ApplicationRecord
  belongs_to :user
  has_many :knowledges, dependent: :destroy
  scope :id_order, -> { order(id: :desc) }
  scope :with_knowledges, -> { joins(:knowledges).group(:id) }
  scope :without_knowledges, -> {
    select("words.*, knowledges.url").left_outer_joins(:knowledges).where("knowledges.id IS NULL")
  }
  accepts_nested_attributes_for :knowledges, allow_destroy: true,
                                             reject_if: ->(attributes) { attributes["url"].blank? }

  validates :content, presence: true, length: { maximum: 50 }
end
