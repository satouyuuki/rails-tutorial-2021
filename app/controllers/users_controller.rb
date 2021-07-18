class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    # どんなプロパティーでもdbに送られてしまうから危険
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで行う
      log_in @user
      flash[:success] = "Wellcom to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end