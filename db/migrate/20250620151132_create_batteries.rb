class CreateBatteries < ActiveRecord::Migration[8.0]
  def change
    create_table :batteries do |t|
      t.string :name
      t.integer :capacity
      t.boolean :active

      t.timestamps
    end
  end
end
