class Availability < ApplicationRecord
 has_many :reservations, dependent: :destroy

 validates :date, :time, presence: true
 validates :total_slots, numericality: { greater_than: 0 }

 def reserved_slots
    reservations.sum(:slot_count)
 end

 def available_slots
    total_slots - reserved_slots
 end
end
