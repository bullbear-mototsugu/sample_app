class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive:false }

  before_save { self.email = email.downcase }

end
