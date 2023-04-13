class AddIndicesToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :artists, :name, unique: true

    add_index :book_entries, [:book_id, :story_id], unique: true

    add_index :books, :issue, unique: true

    add_index :roles, [:artist_id, :story_id, :task], unique: true

    add_index :stories, :code, unique: true
  end
end
