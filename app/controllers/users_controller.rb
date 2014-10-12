class UsersController < ApplicationController


  def new
    @user = User.new
  end


  def show
    @user = User.find(params[:id])
  end

  def create
    # @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params)
    if @user.save
      # 特殊な変数flash
      flash[:success] = "Welcome to the Sample App!"
      # user_urlへリダイレクトと同様
      redirect_to @user
    else
      render 'new'
    end
  end

  def user_params
    # strong parameters機能を使って、POST可能なパラメータを許可
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
