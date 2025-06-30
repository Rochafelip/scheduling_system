class Admin::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show]
  
  def index
    @resevations = Reservation
      .includes(:user, availability: :battery)
      .order(created_at: :desc)
      
    render plain: "Total de reservas: #{@reservations.count}"
  end

  def show
    render plain: <<~TEXT
      Reserva ##{@reservation.id}
      Cliente: #{@reservation.user.name} (#{@reservation.user.cpf})
      Pista: #{@reservation.availability.battery.name}
      Data: #{@reservation.availability.date.strftime("%d/%m/%Y")}
      Hora: #{@reservation.availability.time.strftime("%H:%M")}
      Vagas: #{@reservation.slot_count}
      Status: #{@reservation.payment_status}
    TEXT
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
