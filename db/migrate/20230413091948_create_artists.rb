class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.date :born
      t.date :died
      t.string :nationality

      t.timestamps
    end
  end
end
