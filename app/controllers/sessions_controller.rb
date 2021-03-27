class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if auth
      
    else
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        if !@user.nil?
          @password_error = "Password not matching"
        end
        render "sessions/new"
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
