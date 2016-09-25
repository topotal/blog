class PublishDateDefaultNow < ActiveRecord::Migration
  def change
    change_column :entries, :publish_date, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
