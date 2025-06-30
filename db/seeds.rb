require 'holidays'

puts "🏁 Criando pistas (batteries)..."

Battery.create!(
  name: "Pista Azul",
  capacity: 16,
  active: true
)

Battery.create!(
  name: "Pista Vermelha",
  capacity: 12,
  active: true
)

puts "✅ Pistas criadas!"

puts "🌱 Criando horários para o mês de julho..."

HORARIOS = ["14:00", "15:00", "16:00"]
TOTAL_SLOTS = 16
REGIONS = [:br]

batteries = Battery.where(active: true)

if batteries.empty?
  puts "⚠️ Nenhuma pista ativa encontrada."
else
  (1..31).each do |day|
    date = Date.new(Time.zone.today.year, 7, day)
    kind = Holidays.on(date, *REGIONS).any? ? "feriado" : "normal"

    batteries.each do |battery|
      HORARIOS.each do |hora_str|
        time = Time.zone.parse(hora_str)

        unless Availability.exists?(battery_id: battery.id, date: date, time: time)
          Availability.create!(
            battery: battery,
            date: date,
            time: time,
            total_slots: TOTAL_SLOTS,
            kind: kind
          )
          puts "✅ Criado: #{date} #{hora_str} - #{battery.name} (#{kind})"
        end
      end
    end
  end

  puts "🎉 Horários de julho criados com sucesso!"
end
