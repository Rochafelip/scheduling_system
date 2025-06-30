class AvailabilitiesController < ApplicationController
  def index
    @availabilities = Availability
      .includes(:battery)
      .where("date >= ?", Time.zone.today)
      .order(:date, :time)
      .select { |a| a.available_slots > 0 }
  end
end
