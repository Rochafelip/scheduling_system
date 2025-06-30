class Admin::BatteriesController < ApplicationController
  def index
    @batteries = Battery.all.order(:name)
    render plain: "Listando #{@batteries.count} baterias"
  end

  def new
    @battery = Battery.new
    render plain: "Formulário para nova bateria"
  end

  def create
    @battery = Battery.new(battery_params)

    if @battery.save
      redirect_to admin_batteries_path, notice: "Bateria criada com sucesso"
    else
      render plain: @battery.errors.full_messages.to_sentence
    end
  end

  def edit
    render plain: "Formulário para editar bateria #{@battery.name}"
  end

  def update
    if @battery.update(battery_params)
      redirect_to admin_batteries_path, notice: "Bateria atualizada com sucesso"
    else
      render plain: @battery.errors.full_messages.to_sentence
    end
  end
  
    private

  def set_battery
    @battery = Battery.find(params[:id])
  end

  def battery_params
    params.require(:battery).permit(:name, :capacity, :active)
  end
end
