class Knowledge < ApplicationRecord
  belongs_to :word
  default_scope { order(understanding: :desc, updated_at: :desc) }
  validates :url, url: true
end
