class Word < ApplicationRecord
  belongs_to :user
  has_many :knowledges
  accepts_nested_attributes_for :knowledges, allow_destroy: true,
  reject_if: lambda { |attributes| attributes["url"].blank? }
end
