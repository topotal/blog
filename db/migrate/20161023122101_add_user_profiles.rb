class AddUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :screen_name
      t.text :description
      t.string :image_id
      t.string :image_filename
      t.integer :image_filesize
      t.string :image_content_type
      t.references :user
    end
  end
end
