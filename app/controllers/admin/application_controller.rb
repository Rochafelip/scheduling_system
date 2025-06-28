class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  private

  def require_admin
    redirect_to root_path, alert: "Acesso não autorizado" unless current_user.admin?
  end
end
