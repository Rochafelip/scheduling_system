class UsersController < ApplicationController
  before_validation :normalize_cpf
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_reservation_path(cpf: @user.cpf, name: @user.name, phone: @user.phone), notice: "Usuário criado com sucesso"
    else
      render :new
  end

  def normalize_cpf
    self.cpf = CPF.new(cpf).stripped if cpf.present?
  end
end
