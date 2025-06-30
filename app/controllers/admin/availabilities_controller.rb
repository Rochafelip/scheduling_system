class Admin::AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:edit, :update]
  before_action :set_batteries, only: [:new, :create, :edit, :update]
  def index
    @availabilities = Availability
      .includes(:battery)
      .order(date: :asc, time: :asc)
    
    render plain: "Total de horários cadastrados: #{@availabilities.count}"
  end

  def new
    @availability = Availability.new
    render plain: "Formulário para novo horário"
  end

  def create
    @availability = Availability.new(availability_params)

    if @availability.save
      redirect_to admin_availabilities_path, notice: "Horário criado com sucesso"
    else
      render plain: @availability.errors.full_messages.to_sentence
    end
  end

  def edit
      render plain: "Formulário para editar horário de #{@availability.battery.name} em #{@availability.date} #{@availability.time}"
  end

  def update
    if @availability.update(availability_params)
      redirect_to admin_availabilities_path, notice: "Horário atualizado com sucesso"
    else
      render plain: @availability.errors.full_messages.to_sentence
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
