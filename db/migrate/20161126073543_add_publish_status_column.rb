class AddPublishStatusColumn < ActiveRecord::Migration
  def change
    add_column :entries, :published, :boolean, default: false, null: false
  end
end
