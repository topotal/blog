class AddUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :screen_name
      t.text :description
      t.references :user
      t.references :image
    end
  end
end
