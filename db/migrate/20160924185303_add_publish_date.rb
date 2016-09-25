class AddPublishDate < ActiveRecord::Migration
  def change
    add_column :entries, :publish_date, :datetime, null: false, default: '0000-00-00 00:00:00'
  end
end
