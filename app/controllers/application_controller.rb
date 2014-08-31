class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :permit_params
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def permit_params
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    params[resource] &&= send(:resource_params) if respond_to?(:resource_params, true)
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_page_path
    elsif resource.is_a?(User)
      if resource.group
        resource.group
      else
        edit_user_registration_path
      end
    else
      root_path
    end
  end

  protected

    def configure_permitted_parameters
      permit_array = [:first_name, :last_name, :username, :email, :password, :password_confirmation, :group_id]
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(permit_array)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(permit_array)
      end
    end
end
