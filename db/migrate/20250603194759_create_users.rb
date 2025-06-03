class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
    t.string :name
    t.string :cpf
    t.integer :role, default: 0
    t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :users, :cpf, unique: true
  end
end
