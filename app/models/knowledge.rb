# == Schema Information
#
# Table name: knowledges
#
#  id            :integer          not null, primary key
#  url           :string(255)      not null
#  word_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  understanding :integer          default(0)
#
# Indexes
#
#  index_knowledges_on_understanding  (understanding)
#  index_knowledges_on_word_id        (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (word_id => words.id)
#

class Knowledge < ApplicationRecord
  belongs_to :word
  scope :understanding_order, -> { order(understanding: :desc) }
  validates :url, presence: true, url: true
end
