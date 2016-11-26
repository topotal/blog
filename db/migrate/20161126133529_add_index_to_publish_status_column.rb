class AddIndexToPublishStatusColumn < ActiveRecord::Migration
  def change
    add_index :entry, :published
  end
end
