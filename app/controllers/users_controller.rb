class UsersController < ApplicationController
  def new
  end

  def create
    check_password(params["user"]["password_confirmation"], user_params["password"])
    user = User.new(user_params)
    create_user(user)
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
    if check_password != password
      redirect_to_new_user
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
