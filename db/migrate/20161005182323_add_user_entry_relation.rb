class AddUserEntryRelation < ActiveRecord::Migration
  def change
    change_table :entries do |t|
      t.belongs_to :user
    end
  end
end
