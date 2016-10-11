class AddFileColumnImageTable < ActiveRecord::Migration
  def change
    add_column :images, :image_id, :string
    add_column :images, :image_filename, :string
    add_column :images, :image_filesize, :integer
    add_column :images, :image_content_type, :string
  end
end
