class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true
      t.integer :task

      t.timestamps
    end
  end
end
