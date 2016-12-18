class UseRefileAttachmentUrl < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :image_url
    remove_column :images, :url
  end
end
