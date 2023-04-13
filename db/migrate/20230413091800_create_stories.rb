class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :code, null: false
      t.string :url
      t.date :published
      t.string :origin
      t.integer :pages, default: 0

      t.timestamps
    end
  end
end
