class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id # session idの発行（デフォルトではCookie)
      flash[:success] = 'ログインしました'
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
