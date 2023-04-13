class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :issue, null: false
      t.string :title, null: false
      t.integer :published
      t.integer :pages, default: 0
      t.string :url

      t.timestamps
    end
  end
end
