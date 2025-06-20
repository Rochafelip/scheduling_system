class UpdateAvailabilityUniqueIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :availabilities, name: "index_availabilities_on_date_and_time"
    add_index :availabilities, [:date, :time, :battery_id], unique: true, name: "index_availabilities_on_date_time_battery"
  end
end
