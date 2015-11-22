class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, default: "", null: false
    add_column :users, :provider, :string, default: "", null: false
    add_column :users, :access_token, :string
    add_column :users, :secret_token, :string
  end
end
