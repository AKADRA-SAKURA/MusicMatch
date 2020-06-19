class AddBodyToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :title, :string
    add_column :tweets, :artist, :string
    add_column :tweets, :writer, :string
    add_column :tweets, :composer, :string
    add_column :tweets, :published, :text
    add_column :tweets, :record, :text
    add_column :tweets, :online, :text
  end
end
