class RenameEyeCatchingToEyeCatchImageUrl < ActiveRecord::Migration
  def change
    rename_column :entries, :eye_catching, :eye_catch_image_url
  end
end
