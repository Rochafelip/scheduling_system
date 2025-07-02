class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :availability

  validates :slot_count, numericality: { greater_than: 0 }
  validate :not_exceed_availability
  validates :slot_count, presence: true
  validates :availability_id, uniqueness: { scope: :user_id, message: "já possui uma reserva para este horário" }

  enum :payment_status, { pendente: 0, pago_local: 1, pago_online: 2, expirada: 3 }, default: :pendente
  
  def mark_as_paid!(method = :pago_local)
    update!(
      payment_status: method,
      paid_at: Time.current
    )
  end

  def not_exceed_availability
    return if availability.blank? || slot_count.blank?

    if availability.reserved_slots + slot_count.to_i > availability.total_slots
      errors.add(:slot_count, "excede o número de vagas disponíveis para esse horário")
    end
  end

  def expired?
    expires_at.present? && Time.current > expires_at && pendente?
  end
end
