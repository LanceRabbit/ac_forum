class ModfiyFirendshipColunms < ActiveRecord::Migration[5.1]
  def change
    rename_column :friendships, :following_id, :friend_id
  end
end
