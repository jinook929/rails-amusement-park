class UsersController < ApplicationController
  def show
    redirect_to "/" if not logged_in?
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @name_error = @user.errors[:name][0]
      @password_error = @user.errors[:password][0]
      # @password_confirmation_error = @user.errors[:password_confirmation][0]
      render :new 
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :happiness, :nausea, :height, :tickets, :admin)
  end
end
