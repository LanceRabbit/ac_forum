class Post < ApplicationRecord
  validates_presence_of :title, :content
  
  #上傳圖檔
  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :post_categories
  has_many :categories, through: :post_categories
  
  has_many :replies

  LEVEL = { 
       '1': 'All',
       '2': 'Friend',
       '3': 'Private'
      } 


  scope :published, -> { where(published: true) }

  scope :published, ->(level) { where("published = ? and level <=  ?",true, level) }  


end
