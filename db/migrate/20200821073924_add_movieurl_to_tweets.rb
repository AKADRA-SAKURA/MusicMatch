class AddMovieurlToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :movieurl, :text
  end
end
