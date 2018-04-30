class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string   
    add_column :users, :role, :string,   default: "normal" , null: false
    add_column :users, :avatar, :string  
    add_column :users, :description, :text
  end
end
