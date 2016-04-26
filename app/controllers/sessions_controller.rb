class SessionsController < ApplicationController
  def new
  end

  def create
    params[:session][:email].downcase!
    @user = User.find_by(session_params)
    if @user && @user.authenticate(params[:session][:password])
      session[:current_user_id] = @user.id
      redirect_to links_path
    else
      flash[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  private
  def session_params
    params.require(:session).permit(:email)
  end
end
