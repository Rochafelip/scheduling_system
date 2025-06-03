class AddAvailabilityToReservations < ActiveRecord::Migration[8.0]
  def change
    add_reference :reservations, :availability, null: false, foreign_key: true
  end
end
