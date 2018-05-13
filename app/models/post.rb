class Post < ApplicationRecord
  validates_presence_of :title, :content
  
  #上傳圖檔
  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :post_categories
  has_many :categories, through: :post_categories
  
  has_many :replies

  # 收藏
  has_many :collections, dependent: :destroy
  # post 被很多user收藏
  has_many :collected_users, through: :collections, source: :user
  
  LEVEL = { 
       '1': 'All',
       '2': 'Friend',
       '3': 'Private'
      } 


  scope :published, -> { where(published: true) }

  scope :published, ->(level) { where("published = ? and level <=  ?",true, level) }  


  # 驗證使用者是否已點選過收藏按鈕
  def is_collected?(user)
    self.collected_users.include?(user)
  end

end
