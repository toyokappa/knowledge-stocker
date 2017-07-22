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

class Word < ApplicationRecord
  belongs_to :user
  has_many :knowledges, dependent: :destroy
  accepts_nested_attributes_for :knowledges, allow_destroy: true,
  reject_if: lambda { |attributes| attributes["url"].blank? }

  validates :content, presence: true, length: { maximum: 50 }
end
