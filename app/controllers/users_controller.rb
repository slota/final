class UsersController < ApplicationController
  def new
  end

  def create
    if check_password(params["user"]["password_confirmation"], user_params["password"])
      params["user"]["email"].downcase!
      user = User.new(user_params)
      create_user(user)
    else
      flash[:notice] = "Passwords do not match"
      redirect_to_new_user
    end
  end

  def destroy
    session[:current_user_id] = []
    redirect_to root_path
  end

  private

  def create_user(user)
    if user.save
      session[:current_user_id] = user.id
      redirect_to links_path
    else
      redirect_to_new_user
    end
  end

  def redirect_to_new_user
    redirect_to new_user_path
  end

  def check_password(check_password, password)
    check_password == password
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
