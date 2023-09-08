class AddSortTitleToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :sort_title, :string
  end
end
