class AddNameAndRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string,  null: false
    add_column :users, :last_name,  :string,  null: false
    add_column :users, :role,       :integer, null: false, default: 0
  end
end
