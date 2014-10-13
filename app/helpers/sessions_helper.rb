module SessionsHelper

  def sign_in(user)

    # 1.トークンを新規作成する
    # 2.暗号化されていないトークンをブラウザのクッキーに保存する
    # 3.暗号化したトークンをusersテーブルへ更新する
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))

    self.current_user = user
  end

  # 要素代入を定義しているcurrent_user=という関数。引数はuser。
  def current_user=(user)
    @current_user = user
  end

  def current_user
    # 暗号化して、usersテーブルのremember_tokenと比べる
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # ログインしている = @current_userがnilでない かどうか
  def signed_in?
    !current_user.nil?
  end

  # ログアウト
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
