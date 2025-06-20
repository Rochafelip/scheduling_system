class AddBatteryToAvailabilities < ActiveRecord::Migration[8.0]
  def change
    add_reference :availabilities, :battery, null: false, foreign_key: true
  end
end
