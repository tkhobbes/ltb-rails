class AddPositionsToBookEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :book_entries, :position, :integer
    BookEntry.order(:updated_at).each.with_index(1) do |book_entry, index|
      book_entry.update_column :position, index
    end
    add_index :book_entries, [:book_id, :position], unique: true
  end
end
