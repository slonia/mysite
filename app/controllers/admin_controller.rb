class AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end
end
