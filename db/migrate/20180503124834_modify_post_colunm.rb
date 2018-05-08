class ModifyPostColunm < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :published, :boolean, default: false
    add_column :posts, :last_replied, :datetime, default: Time.zone.now
    remove_column :posts, :level
    add_column :posts, :level, :integer, default: 1
  end
end
