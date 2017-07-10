class Knowledge < ApplicationRecord
  belongs_to :word
  default_scope { order(understanding: :desc) }
end
