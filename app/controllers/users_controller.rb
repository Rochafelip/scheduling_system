class UsersController < ApplicationController
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
end
