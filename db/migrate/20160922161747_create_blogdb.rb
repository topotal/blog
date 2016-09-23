class CreateBlogdb < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.text :eye_catching
      t.datetime :created_at
      t.datetime :updated_at
    end
    create_table :images do |t|
      t.text :url
      t.datetime :created_at
      t.datetime :updated_at
    end
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :access_key
      t.string :access_secret_key
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
