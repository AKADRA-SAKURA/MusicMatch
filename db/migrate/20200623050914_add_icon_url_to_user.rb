class AddIconUrlToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :icon_url, :string
  end
end
