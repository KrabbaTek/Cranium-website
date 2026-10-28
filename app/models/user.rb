class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :name, presence: true

  has_secure_password

  has_many :packages, dependent: :destroy
end
