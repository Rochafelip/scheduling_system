# app/services/availability/feriado_checker.rb
module Availability
  class FeriadoChecker
    REGIONS = [:br_pe]

    def self.kind_for(date)
      feriado = Holidays.on(date, *REGIONS).first
      feriado ? "feriado" : "normal"
    end

    def self.feriado?(date)
      Holidays.on(date, *REGIONS).any?
    end
  end
end
