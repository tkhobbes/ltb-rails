class AddCodeToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :code, :string, null: false
    add_index :books, :code, unique: true
    remove_index :books, %i[publication issue], unique: true
  end
end
