class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 發表文章
  has_many :posts, dependent: :destroy
  # 回覆文章
  has_many :replies, dependent: :destroy

  # 收藏
  has_many :collections, dependent: :destroy
  # user 收藏很多文章
  # 避免與其他命名混肴,collected_posts
  # 需另加 source 告知 Model name(指定 Model name，慣例使用單數)
  has_many :collected_posts, through: :collections, source: :post

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  #透過Friendship的foreign_key取得追隨者的資料
  has_many :self_friends, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  
  ROLE = { 
       'normal': 'normal',
       'admin': 'admin'
      } 

  def admin?
    self.role == "admin"
  end
end
