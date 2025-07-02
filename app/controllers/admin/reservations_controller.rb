class Admin::ReservationsController < Admin::BaseController
  before_action :set_reservation, only: [:show]

  def index
    # Usa policy_scope para aplicar a restrição correta de visibilidade
    @reservations = policy_scope(
      Reservation.includes(:user, availability: :battery).order(created_at: :desc)
    )
    
    authorize Reservation # Verifica permissão geral de acessar reservas no admin

    text = @reservations.map do |r|
      "##{r.id} - #{r.user.name} | #{r.availability.date.strftime("%d/%m")} #{r.availability.time.strftime("%H:%M")} | #{r.slot_count} vagas | #{r.payment_status}"
    end.join("\n")

    render plain: "Total de reservas: #{@reservations.count}\n\n#{text}"
  end

  def show
    authorize @reservation # Autoriza a ação show para o registro carregado

    render plain: <<~TEXT
      Reserva ##{@reservation.id}
      Cliente: #{@reservation.user&.name} (#{@reservation.user&.cpf})
      Pista: #{@reservation.availability&.battery&.name}
      Data: #{@reservation.availability&.date.strftime("%d/%m/%Y")}
      Hora: #{@reservation.availability&.time.strftime("%H:%M")}
      Vagas: #{@reservation.slot_count}
      Status: #{@reservation.payment_status}
    TEXT
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
