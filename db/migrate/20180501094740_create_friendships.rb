class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :following_id
      t.boolean :status ,  default: false

      t.timestamps
    end
    add_index :friendships, :user_id
  end
end
