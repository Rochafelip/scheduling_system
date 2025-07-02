class Availability < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :battery

  validates :date, uniqueness: { scope: [:time, :battery_id], message: "já possui disponibilidade nesse horário para essa pista" }
  validates :total_slots, numericality: { greater_than: 0 }
  validate :not_on_holiday

  def reserved_slots
    reservations.sum(:slot_count)
  end

  def available_slots
    total_slots - reserved_slots
  end

  private

  def not_on_holiday
    return unless date.present?

    if Holidays.on(date, :br_pe).any?
      errors.add(:date, "não pode ser um feriado")
    end
  end
end
