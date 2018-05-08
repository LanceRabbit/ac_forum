class Post < ApplicationRecord
  validates_presence_of :title, :content
  
  #上傳圖檔
  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :post_categories
  has_many :categories, through: :post_categories
  
  LEVEL = { 
       '1': 'All',
       '2': 'Friend',
       '3': 'Private'
      } 

end
