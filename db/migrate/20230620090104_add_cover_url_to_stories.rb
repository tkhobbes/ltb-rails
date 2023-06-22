class AddCoverUrlToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :cover_url, :string
  end
end
