class Knowledge < ApplicationRecord
  belongs_to :word
  scope :understanding_order, -> { order(understanding: :desc) }
  validates :url, presence: true, url: true
end
