class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  helper_method :current_user
  helper_method :current_ability

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :root, alert: exception.message
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def authorize
    redirect_to :welcome, alert: 'Not authorized' unless current_user.present?
  end
end
