class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.integer :born
      t.integer :died
      t.string :nationality

      t.timestamps
    end
  end
end
