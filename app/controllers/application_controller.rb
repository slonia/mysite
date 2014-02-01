class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= respond_to?(:current_admin) ? Ability.new(current_admin) : Ability.new(current_user)
  end
end
