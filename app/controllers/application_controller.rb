class ApplicationController < ActionController::Base
  include DeviceFormat
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # exemplo de parâmetros extras para o Devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :cpf, :phone])
  end
end
