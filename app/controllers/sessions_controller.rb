class SessionsController < ApplicationController
  skip_before_filter :authorize, only: :create

  def create
    @sign_in = User::SignIn.new(request.env["omniauth.auth"])
    session[:user_id] = @sign_in.user.id

    redirect_to :repositories, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, :notice => "Signed out!"
  end
end
