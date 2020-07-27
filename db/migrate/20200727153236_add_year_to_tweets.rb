class AddYearToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :year, :integer
  end
end
