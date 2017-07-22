# == Schema Information
#
# Table name: knowledges
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  word_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  understanding :integer          default(0)
#

class Knowledge < ApplicationRecord
  belongs_to :word
  scope :understanding_order, -> { order(understanding: :desc) }
  validates :url, presence: true, url: true
end
