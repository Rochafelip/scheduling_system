# lib/tasks/reservations.rake
namespace :reservations do
  desc "Expira reservas pendentes com prazo vencido"
  task expire: :environment do
    puts "Iniciando expiração de reservas pendentes..."

    expired = Reservation.where(payment_status: :pendente)
                         .where("expires_at < ?", Time.current)

    expired.find_each do |reservation|
      puts "Expirando reserva ##{reservation.id} (expirada em #{reservation.expires_at})"
      reservation.destroy 
    end

    puts "Finalizado. Total expiradas: #{expired.count}"
  end
end
