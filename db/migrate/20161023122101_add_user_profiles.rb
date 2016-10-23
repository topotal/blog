class AddUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.string :screen_name
      t.string :image_path
      t.text :description
    end
  end
end
