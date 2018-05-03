class PostCategory < ApplicationRecord
  # 確保特定 category_id 下，只能有一個 post_id
  validates :post_id, uniqueness: { scope: :category_id }

  belongs_to :post
  belongs_to :category
end
