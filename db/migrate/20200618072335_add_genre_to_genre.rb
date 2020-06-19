class AddGenreToGenre < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :genre, :string
  end
end
