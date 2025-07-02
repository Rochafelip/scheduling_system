class ApplicationController < ActionController::Base
  include DeviceFormat
  allow_browser versions: :modern

  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :skip_authorization?
  after_action :verify_policy_scoped, unless: :skip_policy_scope?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :cpf, :phone])
  end

  private

  def skip_authorization?
    devise_controller? || !pundit_action?
  end

  def skip_policy_scope?
    devise_controller? || !pundit_action? || action_name != "index"
  end

  def pundit_action?
    self.class.action_methods.include?(action_name)
  end

end
