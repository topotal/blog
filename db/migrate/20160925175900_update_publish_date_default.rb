class UpdatePublishDateDefault < ActiveRecord::Migration
  def change
    execute "UPDATE entries SET publish_date='1970-01-01T00:00:00' WHERE publish_date='0000-00-00 00:00:00';"
  end
end
