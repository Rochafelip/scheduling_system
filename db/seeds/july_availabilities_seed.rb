require 'holidays'

puts "🏁 Criando corridas para Julho..."

Battery.where(active: true).find_each do |battery|
  # Horários de corridas (30 min cada) das 9:00 às 21:30, pulando intervalos de descanso
  corrida_start_times = []
  current_time = Time.zone.parse("09:00")
  end_time = Time.zone.parse("21:30")

  while current_time < end_time
    # Pula intervalo das 12:00 às 14:00
    if current_time >= Time.zone.parse("12:00") && current_time < Time.zone.parse("14:00")
      current_time = Time.zone.parse("14:00")
      next
    end

    # Pula intervalo das 18:00 às 19:00
    if current_time >= Time.zone.parse("18:00") && current_time < Time.zone.parse("19:00")
      current_time = Time.zone.parse("19:00")
      next
    end

    corrida_start_times << current_time.strftime("%H:%M")
    current_time += 30.minutes
  end

  (1..31).each do |day|
    date = Date.new(Time.zone.today.year, 7, day)
    kind = Holidays.on(date, :br).any? ? "feriado" : "normal"

    corrida_start_times.each do |hora_str|
      time = Time.zone.parse(hora_str)

      unless Availability.exists?(battery_id: battery.id, date: date, time: time)
        Availability.create!(
          battery: battery,
          date: date,
          time: time,
          total_slots: 15,
          kind: kind
        )
        puts "✅ Criado: #{date} #{hora_str} - #{battery.name} (#{kind})"
      end
    end
  end
end

puts "🎉 Corridas de Julho criadas com sucesso!"
