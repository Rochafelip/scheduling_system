class AddPaymentDetailsToReservations < ActiveRecord::Migration[8.0]
  def change
    add_column :reservations, :payment_reference, :string
    add_column :reservations, :expires_at, :datetime
    add_column :reservations, :paid_at, :datetime
  end
end
