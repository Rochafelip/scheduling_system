class AddKindToAvailabilities < ActiveRecord::Migration[8.0]
  def change
    add_column :availabilities, :kind, :string, null: false, default: "normal"
  end
end
