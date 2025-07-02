class Admin::AvailabilitiesController < Admin::BaseController
  before_action :set_availability, only: [:edit, :update]
  before_action :set_batteries, only: [:new, :create, :edit, :update]

  def index
    @availabilities = policy_scope(Availability.includes(:battery).order(date: :asc, time: :asc))
    render plain: "Total de horários cadastrados: #{@availabilities.count}"
  end

  def new
    @availability = Availability.new
    authorize @availability
    render :new
  end

  def create
    @availability = Availability.new(availability_params)
    authorize @availability

    if @availability.save
      redirect_to admin_availabilities_path, notice: "Horário criado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @availability
    render :edit
  end

  def update
    authorize @availability

    if @availability.update(availability_params)
      redirect_to admin_availabilities_path, notice: "Horário atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def set_batteries
    @batteries = Battery.where(active: true).order(:name)
  end

  def availability_params
    params.require(:availability).permit(:battery_id, :date, :time, :total_slots)
  end
end
