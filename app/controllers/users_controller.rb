class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    # debugger
  end

  def new
    @user = User.new
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def create
    # どんなプロパティーでもdbに送られてしまうから危険
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      # UserMailer.account_activation(@user).deliver_now #リファクタリング
      @user.send_activation_email
      flash[:info] = "Please check your email to active your account."
      redirect_to root_url
      # 保存の成功をここで行う
      # log_in @user
      # flash[:success] = "Wellcom to the Sample App!"
      # redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
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
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
