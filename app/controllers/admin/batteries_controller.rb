class Admin::BatteriesController < Admin::BaseController
  before_action :set_battery, only: [:edit, :update]

  def index
    @batteries = policy_scope(Battery.order(:name))
    authorize Battery
    render plain: "Listando #{@batteries.count} baterias"
  end

  def new
    @battery = Battery.new
    authorize @battery
    render :new
  end

  def create
    @battery = Battery.new(battery_params)
    authorize @battery

    if @battery.save
      redirect_to admin_batteries_path, notice: "Bateria criada com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @battery
    render :edit
  end

  def update
    authorize @battery

    if @battery.update(battery_params)
      redirect_to admin_batteries_path, notice: "Bateria atualizada com sucesso"
    else
      render :edit, status: :unprocessable_entity
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
