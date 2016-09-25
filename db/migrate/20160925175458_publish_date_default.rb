class PublishDateDefault < ActiveRecord::Migration
  def change
    change_column :entries, :publish_date, :datetime, null: false, default: "1970-01-01T00:00:00"
  end
end
