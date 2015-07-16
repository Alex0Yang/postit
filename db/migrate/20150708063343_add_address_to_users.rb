class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :email, :string
    rename_column :users, :username, :name
  end
end
