class SessionsController < ApplicationController
  skip_before_action :authorize
  layout 'guest', only: :failure

  def create
    @sign_in = User::SignIn.new(request.env['omniauth.auth'])
    user = @sing_in.save!
    session[:user_id] = user.id

    redirect_to :repositories, notice: 'Signed in!'
  end

  def failure
    flash[:alert] = params[:message]
  end

  def destroy
    session.clear
    redirect_to :root, notice: 'Signed out!'
  end
end
