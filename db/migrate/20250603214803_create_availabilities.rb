class CreateAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :availabilities do |t|
    t.date :date, null: false
    t.time :time, null: false
    t.integer :total_slots, default: 16, null: false

      t.timestamps
    end
    add_index :availabilities, [:date, :time], unique: true
  end
end
