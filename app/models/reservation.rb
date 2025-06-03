class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :availability

  validates :slot_count, numericality: { greater_than: 0 }
  validate :not_exceed_availability

  def not_exceed_availability
    return if availability.blank?

    if availability.reserved_slots + slot_count.to_i > availability.total_slots
      errors.add(:slot_count, "excede o número de vagas disponíveis para esse horário")
    end
  end
end
