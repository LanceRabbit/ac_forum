class Category < ApplicationRecord
  validates_presence_of :name
  # 目前設定分類下若有文章，就不允許刪除分類（刪除時拋出 Error）
  # dependent: :destroy/restrict_with_exception/restrict_with_error
  has_many :post_categories, dependent: :restrict_with_error

end
