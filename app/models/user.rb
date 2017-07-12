class User < ApplicationRecord
  has_many :words

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true,
                    email_format: { message: "正しいメールアドレスの形式で入力してください。" }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
