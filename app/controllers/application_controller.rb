class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :permit_params

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_page_path
    else
      root_path
    end
  end

  def permit_params
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    params[resource] &&= send(:resource_params) if respond_to?(:resource_params, true)
  end
end
