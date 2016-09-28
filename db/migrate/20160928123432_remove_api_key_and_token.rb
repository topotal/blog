class RemoveApiKeyAndToken < ActiveRecord::Migration
  def change
    remove_column :users, :access_key, :string
    remove_column :users, :access_secret_key, :string
  end
end
