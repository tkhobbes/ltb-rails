class AddPortraitUrlToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :portrait_url, :string
  end
end
