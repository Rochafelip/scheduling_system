class Admin::DashboardController < Admin::BaseController
  def index
    today = Time.zone.today

    @reservations_today = Reservation.includes(:user).where(date: today)
    @availabilities_today = Availability.includes(:battery).where(date: today)
    @batteries_active = Battery.where(active: true)

    @total_slots_today = @availabilities_today.sum(:total_slots)
    @used_slots_today = @reservations_today.sum(:slot_count)
    @available_slots_today = @total_slots_today - @used_slots_today

    render plain: <<~TEXT
      Dashboard Administrativo
      Data: #{today.strftime("%d/%m/%Y")}
      Total de reservas hoje: #{@reservations_today.count}
      Total de horários disponíveis hoje: #{@availabilities_today.count}
      Total de baterias ativas: #{@batteries_active.count}
      Total de vagas hoje: #{@total_slots_today}
      Vagas usadas hoje: #{@used_slots_today}
      Vagas disponíveis hoje: #{@available_slots_today}
    TEXT
  end
end
