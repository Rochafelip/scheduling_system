class ChangeCpfAndNameToNotNullInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :cpf, false
    change_column_null :users, :name, false    
  end
end
