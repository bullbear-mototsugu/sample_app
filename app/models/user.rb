class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive:false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  # ブロックを渡す方法
  before_save { self.email = email.downcase }
  # メソッド参照する方法
  before_create :create_remember_token

  # クラスメソッド
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # クラスメソッド
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # 以下プライベートメソッド
  private
    def create_remember_token
      # オブジェクト内部への要素代入がしたいので、selfで参照する
      # before_saveの下りと同じ
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end
