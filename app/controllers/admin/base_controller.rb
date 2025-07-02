# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  private

  def authorize_admin!
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.admin?
  end
end
