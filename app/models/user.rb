class User < ApplicationRecord
  has_many :words, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true,
                    email_format: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
