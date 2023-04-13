class AddTitleOriginalTitleToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :title, :string
    add_column :stories, :original_title, :string
  end
end
