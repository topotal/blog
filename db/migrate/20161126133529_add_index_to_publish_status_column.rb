class AddIndexToPublishStatusColumn < ActiveRecord::Migration
  def change
    add_index :entries, :published
  end
end
