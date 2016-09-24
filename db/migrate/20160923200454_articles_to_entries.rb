class ArticlesToEntries < ActiveRecord::Migration
  def change
    rename_table :articles, :entries
  end
end
