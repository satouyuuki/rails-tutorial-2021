class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # ユーザーログイン後にユーザー情報のページにリダイレクト
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # remember user
        # redirect_to user
        redirect_back_or user
      else
        message = "Account not activated."
        message += "Check your email for the activation"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラ〜メッセージを作成する
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
