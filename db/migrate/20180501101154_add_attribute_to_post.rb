class AddAttributeToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :views_count, :integer, default: 0
    add_column :posts, :replies_count, :integer, default: 0
    add_column :posts, :level, :string, default: "all"
  end
end
