class UsersController < ApplicationController

  # 要ログインのアクション
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    # @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params)
    if @user.save
      # ログイン
      sign_in @user
      # 特殊な変数flash
      flash[:success] = "Welcome to the Sample App!"
      # user_urlへリダイレクトと同様
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # correct_userをbefore_actionで行っているため、以下1行は不要
    # @user = User.find(params[:id])
  end

  def update
    # correct_userをbefore_actionで行っているため、以下1行は不要
    # @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end



  # 以下プライベートメソッド
  private

    def user_params
      # strong parameters機能を使って、マスアサインメント脆弱性対策。POST可能なパラメータを許可。
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before actions

    # micropostsコントローラでも使うので、SessionHelperへ移動
    # def signed_in_user
      # # session_helperのsigned_in?メソッド
      # # redirect_to signin_url, notice: "Please sign in." unless signed_in?

      # # ログインしてなければいったんセッションにアクセスしたいURLを保存してログイン画面へ遷移
      # unless signed_in?
        # store_location
        # redirect_to signin_url, notice: "Please sign in."
      # end
    # end

    # 更新対象のユーザはログイン中のユーザであるかのチェック
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    # 管理者ユーザかどうかのチェック
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
