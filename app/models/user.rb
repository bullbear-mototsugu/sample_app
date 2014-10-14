class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  # 逆リレーションシップを使ってuser.followersを実装する
  # クラスを明示的に指定してReverseRelationshipクラスを探しに行かないようにする
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive:false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  # ブロックを渡す方法
  before_save { self.email = email.downcase }
  # メソッド参照で指定する方法
  before_create :create_remember_token

  # クラスメソッド
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # クラスメソッド
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # このコードは準備段階です。
    # 完全な実装は第11章「ユーザーをフォローする」を参照してください。
    # Micropost.where("user_id = ?", id)
    
    Micropost.from_users_followed_by(self)
  end


  def following?(other_user)
    # self.relationshipsと明示的にselfを書いても同じ
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    # self.relationshipsを明示的にselfを書いても同じ
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # 以下プライベートメソッド
  private
    def create_remember_token
      # オブジェクト内部への要素代入がしたいので、selfで参照する
      # before_saveの下りと同じ
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end
