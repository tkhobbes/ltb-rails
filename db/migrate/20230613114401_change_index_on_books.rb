class ChangeIndexOnBooks < ActiveRecord::Migration[7.0]
  def change
    add_index :books, %i[publication issue], unique: true
    remove_index :books, :issue, unique: true
  end
end
