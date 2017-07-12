class User < ApplicationRecord
  has_secure_password
  has_many :words

  validates :name, presence: true, length: { maximum: 30 }
end
