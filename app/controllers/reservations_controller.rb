class ReservationsController < ApplicationController
  before_action :load_availabilities, only: [:new, :create]
  before_action :load_user_data, only: [:new, :create]

  def new
    @reservation = Reservation.new
  end

  def create
    user = User.find_or_initialize_by(cpf: params[:reservation][:cpf])
    user.assign_attributes(
      name: params[:reservation][:name],
      phone: params[:reservation][:phone]
    )

    if user.save
      availability = Availability.find(reservation_params[:availability_id])

      @reservation = user.reservations.build(
        availability: availability,
        slot_count: reservation_params[:slot_count]
        date: availability.date,
        time: availability.time
      )

      if @reservation.save
        redirect_to reservation_path(@reservation), notice: "Reserva criada com sucesso"
      else
        flash.now[:alert] = @reservation.errors.full_messages.to_sentence
        render :new
      end
    else
      flash.now[:alert] = user.errors.full_messages.to_sentence
      render :new
  end
end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:availability_id, :slot_count)
  end

  def load_availabilities
    @availabilities = Availability.includes(:battery).where("date >= ?", Time.zone.today)
  end

  def load_user_data
    @user_data = {
      cpf: params.dig(:reservation, :cpf),
      name: params.dig(:reservation, :name),
      phone: params.dig(:reservation, :phone)
    }
  end
end
