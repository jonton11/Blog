class UsersController < ApplicationController # :nodoc:
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(current_user)
    if new_password && @user.update(user_params)
      redirect_to posts_path, notice: 'Account information updated!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def new_password
    (params[:old_password] != params['user']['password']) && (params['user']['password'] == params['user']['password_confirmation'])
  end
end
