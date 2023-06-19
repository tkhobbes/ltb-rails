class AddCodeToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :code, :string, null: false
    add_index :artists, :code, unique: true
    remove_index :artists, :name, unique: true
  end
end
